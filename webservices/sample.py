from webservices.db import _DbObject, _DbGetQuery

#from webservices.drestapi import MetPet

class SampleObject(_DbObject):
    def __init__(self, id = None):
        self.getQuery = _SampleGetQuery();
       
        if id:
            self._get({"sample_id": id})
           
    def get(self, id):
        return self._get({"sample_id": id})
           
    def exists(self):
        return "id" in self.attributes

class _SamplePermissionsQuery(_DbGetQuery):
    def __init__(self):
        self.oneQuery = ()

       
class _SampleGetQuery(_DbGetQuery):
    def __init__(self):
        self.oneQuery = (
            "SELECT "
                "samples.sample_id AS id, "
                "samples.number, "
                "samples.collection_date, "   
                "CASE WHEN samples.public_data = 'Y' THEN TRUE ELSE FALSE END AS public_data, "
                "samples.country, "
                "samples.description, "
                "samples.location_text, "
                "st_y(samples.location) AS latitude, "
                "st_x(samples.location) AS longitude, "
                "owner.name AS owner_name, "
                "collector.name AS collector_name, "
                "rock_type.rock_type AS rock_type_name, "
                "COUNT(subsamples.subsample_id) AS subsamples_count "
            "FROM (((( "
                "samples "
                "LEFT OUTER JOIN subsamples "
                "ON samples.sample_id = subsamples.sample_id ) "
                "LEFT OUTER JOIN users owner "
                "ON samples.user_id = owner.user_id ) "
                "LEFT OUTER JOIN users collector "
                "ON samples.collector_id = collector.user_id ) "
                "LEFT OUTER JOIN rock_type "
                "ON samples.rock_type_id = rock_type.rock_type_id ) "
            "WHERE "
                "samples.sample_id = %(sample_id)s "
            "GROUP BY "
                "samples.sample_id, "
                "samples.number, "
                "samples.collection_date, "
                "samples.public_data, "
                "samples.country, "
                "samples.description, "
                "samples.location_text, "
                "st_y(samples.location), "
                "st_x(samples.location), "
                "owner.name, "
                "collector.name, "
                "rock_type.rock_type "
        )
                       
        self.manyQueries = {
            "aliases": (
                "SELECT "
                    "alias AS name "
                "FROM "
                    "sample_aliases "
                "WHERE "
                    "sample_aliases.sample_id = %(sample_id)s"
            ),
            "minerals": (
                "SELECT "
                    "name "
                "FROM "
                    "minerals, "
                    "sample_minerals "
                "WHERE "
                    "minerals.mineral_id = sample_minerals.mineral_id AND "
                    "sample_minerals.sample_id = %(sample_id)s"
            ),
            "regions": (
                "SELECT "
                    "name "
                "FROM "
                    "regions, "
                    "sample_regions "
                "WHERE "
                    "regions.region_id = sample_regions.region_id AND "
                    "sample_regions.sample_id = %(sample_id)s"
            ),
            "metamorphic_regions": (
                "SELECT "
                    "name "
                "FROM "
                    "metamorphic_regions, "
                    "sample_metamorphic_regions "
                "WHERE "
                    "metamorphic_regions.metamorphic_region_id = sample_metamorphic_regions.metamorphic_region_id AND "
                    "sample_metamorphic_regions.sample_id = %(sample_id)s"
            ),
            "metamorphic_grades": (
                "SELECT "
                    "name "
                "FROM "
                    "metamorphic_grades, "
                    "sample_metamorphic_grades "
                "WHERE "
                    "metamorphic_grades.metamorphic_grade_id = sample_metamorphic_grades.metamorphic_grade_id AND "
                    "sample_metamorphic_grades.sample_id = %(sample_id)s"
            ),
            "references": (
                "SELECT "
                    "name "
                "FROM "
                    "reference, "
                    "sample_reference "
                "WHERE "
                    "reference.reference_id = sample_reference.reference_id AND "
                    "sample_id = %(sample_id)s"
            ),
            "images": (
                "SELECT "
                    "images.filename, "
                    "images.checksum_64x64, "
                    "images.checksum_half, "
                    "images.height, "
                    "images.width, "
                    "image_type.image_type "
                "FROM images, "
                    "image_type "
                "WHERE "
                    "images.image_type_id = image_type.image_type_id AND "
                    "sample_id = %(sample_id)s"
            )
        }


class SampleImagesObject(_DbObject):
    def __init__(self, id = None):
        self.getQuery = _SampleImagesGetQuery();
       
        if id:
            self._get({"sample_id": id})
           
    def get(self, id):
        return self._get({"sample_id": id})
           
    def exists(self):
        return "id" in self.attributes
       
class _SampleImagesGetQuery(_DbGetQuery):
    def __init__(self):
        self.oneQuery = (
            "SELECT "
                "samples.sample_id AS id, "
                "samples.number "
            "FROM "
                "samples "
            "WHERE "
                "samples.sample_id = %(sample_id)s "
        )
                       
        self.manyQueries = {
            "images": (
                "("
                    "SELECT "
                        "images.image_id AS id, "
                        "-1 AS subsample_id, "
                        "images.filename, "
                        "images.checksum, "
                        "images.checksum_64x64, "
                        "image_type.image_type "
                    "FROM "
                        "images, "
                        "image_type "
                    "WHERE "
                        "sample_id = %(sample_id)s AND "
                        "images.image_type_id = image_type.image_type_id"
                ") UNION ("
                    "SELECT "
                        "images.image_id AS id, "
                        "images.subsample_id, "
                        "images.filename, "
                        "images.checksum, "
                        "images.checksum_64x64, "
                        "image_type.image_type "
                    "FROM "
                        "images, "
                        "image_type "
                    "WHERE "
                        "subsample_id IN ("
                            "SELECT "
                                "subsample_id "
                            "FROM "
                                "subsamples "
                            "WHERE "
                                "sample_id = %(sample_id)s"
                        ") AND "
                        "images.image_type_id = image_type.image_type_id"
                ")"
            )
        }