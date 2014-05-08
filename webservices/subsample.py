from webservices.db import _DbObject, _DbGetQuery

# http://127.0.0.1:8000/api/subsample/1216/
class SubsampleObject(_DbObject):
    def __init__(self, id = None):
        self.getQuery = _SubsampleGetQuery();
        
        if id:
            self._get({"subsample_id": id})
            
    def get(self, id):
        return self._get({"subsample_id": id})
            
    def exists(self):
        return "id" in self.attributes
        
class _SubsampleGetQuery(_DbGetQuery):
    def __init__(self):
        self.oneQuery = (
                "SELECT "
                    "subsamples.subsample_id AS id, "
                    "subsamples.name, "
                    "subsamples.public_data AS public, "
                    "subsample_type.subsample_type AS type, "
                    "users.name AS owner_name, "
                    "COUNT(chemical_analyses.chemical_analysis_id) AS chemical_analysis_count, "
                    "("
                        "SELECT "
                            "COUNT(*) "
                        "FROM "
                            "images "
                        "WHERE "
                            "images.subsample_id = subsamples.subsample_id"
                    ") AS image_count "
                "FROM (( "
                    "subsamples "
                    "LEFT OUTER JOIN users "
                    "ON subsamples.user_id = users.user_id ) "
                    "LEFT OUTER JOIN subsample_type "
                    "ON subsamples.subsample_type_id = subsample_type.subsample_type_id ) "
                    "LEFT OUTER JOIN chemical_analyses "
                    "ON subsamples.subsample_id = chemical_analyses.subsample_id "
                "WHERE "
                    "subsamples.subsample_id = %(subsample_id)s "
                "GROUP BY "
                    "subsamples.subsample_id, "
                    "subsamples.name, "
                    "subsamples.public_data, "
                    "subsample_type.subsample_type, "
                    "users.name"
            )

        
# This is displayed on the side of the subsamples page view
class SubsampleImagesTableObject(_DbObject):
    def __init__(self, subsample_id = None):
        self.getQuery = _SubsampleImagesTableGetQuery();
        
        if id:
            self._get({"subsample_id": subsample_id})
            
    def get(self, id):
        return self._get({"subsample_id": subsample_id})

    def exists(self):
        return "*" in self.attributes and len(self.attributes["*"]) > 0

        
class _SubsampleImagesTableGetQuery(_DbGetQuery):
    def __init__(self):
        self.manyQueries = {
            "*": (
                "SELECT "
                    "images.filename, "
                    "images.checksum, "
                    "images.checksum_64x64, "
                    "images.checksum_half, "
                    "images.height, "
                    "images.width, "
                    "image_type.image_type "
                "FROM images, "
                    "image_type "
                "WHERE "
                    "images.image_type_id = image_type.image_type_id AND "
                    "subsample_id = %(subsample_id)s"
                )
            }


# This is displayed on bottom of samples page view
class SubsampleTableObject(_DbObject):
    def __init__(self, sample_id = None):
        self.getQuery = _SubsampleTableGetQuery();
        
        if id:
            self._get({"sample_id": sample_id})
            
    def get(self, id):
        return self._get({"sample_id": sample_id})

    def exists(self):
        return "*" in self.attributes and len(self.attributes["*"]) > 0

        
class _SubsampleTableGetQuery(_DbGetQuery):
    def __init__(self):
        self.manyQueries = {
            "*": (
                "SELECT "
                    "subsamples.subsample_id AS id, "
                    "subsamples.name, "
                    "subsamples.public_data AS public, "
                    "subsample_type.subsample_type AS type, "
                    "users.name AS owner_name, "
                    "COUNT(chemical_analyses.chemical_analysis_id) AS chemical_analysis_count, "
                    "("
                        "SELECT "
                            "COUNT(*) "
                        "FROM "
                            "images "
                        "WHERE "
                            "images.subsample_id = subsamples.subsample_id"
                    ") AS image_count "
                "FROM (( "
                    "subsamples "
                    "LEFT OUTER JOIN users "
                    "ON subsamples.user_id = users.user_id ) "
                    "LEFT OUTER JOIN subsample_type "
                    "ON subsamples.subsample_type_id = subsample_type.subsample_type_id ) "
                    "LEFT OUTER JOIN chemical_analyses "
                    "ON subsamples.subsample_id = chemical_analyses.subsample_id "
                "WHERE "
                    "subsamples.sample_id = %(sample_id)s "
                "GROUP BY "
                    "subsamples.subsample_id, "
                    "subsamples.name, "
                    "subsamples.public_data, "
                    "subsample_type.subsample_type, "
                    "users.name"
                )
            }
