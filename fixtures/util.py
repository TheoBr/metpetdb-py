from django.conf import settings
from django_nose import NoseTestSuiteRunner

class CustomTestSuiteRunner(NoseTestSuiteRunner):
    def setup_databases(self):
        #from django.db import connection as con

        result = super(CustomTestSuiteRunner, self).setup_databases()
        connections = result[0]
        connection = connections[0][0]

        cursor = connection.cursor()

        cursor.execute(self._get_create_queries())

        for query in self._get_insert_queries():
            cursor.execute(query)

        return result

    def _get_create_queries(self):
        import os

        fname = os.path.join(settings.FIXTURES_DIR, 'db_creation_routine.sql')

        f = open(fname)
        query = f.read()

        return query

    def _get_insert_queries(self):
        import os
        import simplejson as sj

        db_tables = ["users", "users_roles", "admin_users", "rock_type", \
            "regions", "samples", "image_format", "image_type", "subsample_type", \
            "subsamples", "images", "reference", "image_reference", \
            "image_comments", "grids", "image_on_grid", "minerals", \
            "mineral_types", "chemical_analyses", "elements", \
            "chemical_analysis_elements", "element_mineral_types", \
            "geometry_columns", "georeference", "mineral_relationships", \
            "oxides", "oxide_mineral_types", "chemical_analysis_oxides", \
            "metamorphic_grades", "metamorphic_regions", "projects", \
            "project_invites", "project_members", "project_samples", \
            "roles", "role_changes", "sample_aliases", \
            "sample_comments", "sample_metamorphic_grades", \
            "sample_metamorphic_regions", "sample_minerals", \
            "sample_reference", "sample_regions", "spatial_ref_sys",\
            "uploaded_files", "xray_image"]

        queries = []
        for db_tablename in db_tables:
            fname = os.path.join(settings.FIXTURES_DIR, db_tablename + '.txt')

            f = open(fname)

            line = f.read()
            line = line.strip("\n")

            print "Loading {}...".format(fname)
            data_val = sj.loads(line)

            for table in data_val:

                table_name = table['table_name']

                for tuple in table['values']:
                    line = "insert into %s(" %table_name
                    for attr in sorted(tuple.keys()):
                        line += attr + ","
                    line = line.strip(",") + ") values ("
                    for attr in sorted(tuple.keys()):
                        line += tuple[attr] + ","
                    line = line.strip(",") + ");"
                    queries.append(line)

        return queries
