"""
   SampleQuery class: keeps track of which conditions are set for 
   each query and constructs different types of queries based on the
   given conditions.

   Given q = SampleQuery()

   Facet Query: will return for each facet, the name and the count
   of values. 
   Use (for facet owner): q.owner_facet()

   Brief Where Query: will return for the current condition, a list of
   results except for the counts. These  are used to populate the map.
   Use: q.get_main_brief()

   Where Query: will return for the current condition, a list of
   results. These are used to populate the list of samples. 
   Use: q.get_main()

   Count Query: will return the total number of samples for a given
   condition. To be used to double check whether to load all of them
   to the interface. Use: q.get_count()

   Limit Query: instead of returning all the tuples in Where, we can
   limit them to a specific number, N. Use: q.get_main_limit(N)


   To do: 

   1. For queries, we can return the query string and the parameters
   separately.  We need to figure out how to use them in the code. The
   WHERE query then needs to be changed.

   2. Add the counts to the WHERE query.

"""


class SampleQuery(object):
    """ Query object for sample searches. Queries the view given by
        VIEW_NAME (current full sample results)
        Holds all query conditions in lists with names _selections
        and constructs queries for the given conditions.

    """

    def __init__ ( self , \
                       rock_type=[], \
                       country=[], \
                       owner_id=[], \
                       mineral_id = [], \
                       region_id = [], \
                       metamorphic_grade_id = [], \
                       metamorphic_region_id = [],\
                       publication_id = []
                       ) :
        self.rock_type_selections = rock_type
        self.country_selections = country
        self.owner_id_selections = owner_id
        self.mineral_id_selections = mineral_id
        self.region_id_selections = region_id
        self.metamorphic_grade_id_selections = metamorphic_grade_id
        self.metamorphic_region_id_selections = metamorphic_region_id
        self.publication_id_selections = publication_id
        self.VIEW_NAME = 'full_sample_results'
        self.SHORT_VIEW_NAME = 'basic_sample_results'
        if len (rock_type + country + owner_id + mineral_id + region_id) == 0:
            self.conditions_set = False
        else:
            self.conditions_set = True

    def get_view_name( self ): 
        """ Use the simpler view if no conditions relevant to the 
            complex view are set. 

        """
        if not self.conditions_set:
            return self.SHORT_VIEW_NAME
        elif (len(self.mineral_id_selections) + \
                  len(self.region_id_selections) + \
                  len(self.metamorphic_grade_id_selections) + \
                  len(self.metamorphic_region_id_selections) + \
                  len(self.publication_id_selections)) == 0:
            return self.SHORT_VIEW_NAME
        else:
            return self.VIEW_NAME

    def set_rock_type( self, rock_type_list ):
        """ Specify a list of rock_type_ids as input, -1 for null values. """
        self.rock_type_selections = rock_type_list
        if len(rock_type_list) > 0:
            self.conditions_set = True

    def set_country( self, country_list ):
        """ Specify a list of countries as input, -1 for null values. """
        self.country_selections = country_list
        if len(country_list) > 0:
            self.conditions_set = True

    def set_owner_id( self, owner_id_list ):
        """ Specify a list of owner_ids as input, -1 for null values. """
        self.owner_id_selections = owner_id_list
        if len(owner_id_list) > 0:
            self.conditions_set = True

    def set_mineral_id( self, mineral_id_list ):
        """ Specify a list of mineral_ids as input, -1 for null values. """
        self.mineral_id_selections = mineral_id_list
        if len(mineral_id_list) > 0:
            self.conditions_set = True

    def set_region_id( self, region_id_list ):
        """ Specify a list of region_ids as input, -1 for null values. """
        self.region_id_selections = region_id_list
        if len(region_id_list) > 0:
            self.conditions_set = True

    def set_metamorphic_grade_id( self, id_list ):
        """ Specify a list of metamorphic grade ids as input,
             -1 for null values. 

        """
        self.metamorphic_grade_id_selections = id_list
        if len(id_list) > 0:
            self.conditions_set = True

    def set_metamorphic_region_id( self, id_list ):
        """ Specify a list of metamorphic region_ids as input,
             -1 for null values. 

        """
        self.metamorphic_region_id_selections = id_list
        if len(id_list) > 0:
            self.conditions_set = True

    def set_publication_id( self, publication_id_list ):
        """ Specify a list of publication_ids as input, -1 for null values. """
        self.publications_id_selections = publication_id_list
        if len(publication_id_list) > 0:
            self.conditions_set = True
    
    def get_facet ( self, field ):
        """ Given the attributes needed for a facet, constructs
            the necessary query and returns the string.
   
        """
        (where_str, params) = self.get_where()
        str = "SELECT " + field + ", count(distinct sample_id) " \
            "FROM " + self.VIEW_NAME + " " + where_str + \
            "GROUP BY " + field
        str = str %params
        return str

    def owner_facet( self ) :
        """ Return list of owners for the given query. """
        return self.get_facet( "owner_id, owner_name " )

    def rock_type_facet( self ) :
        """ Return list of rock types for the given query. """
        return self.get_facet( "rock_type_id, rock_type_name " )

    def country_facet( self ) :
        """ Return list of countries for the given query. """
        return self.get_facet( "country " )

    def mineral_facet( self ) :
        """ Return list of minerals for the given query. """
        return self.get_facet( "sample_mineral_id, sample_mineral_name " )

    def region_facet( self ) :
        """ Return list of regions for the given query. """
        return self.get_facet( "sample_region_id, sample_region_name " )

    def metamorphic_region_facet( self ) :
        """ Return list of metamorphic regions for the given query. """
        return self.get_facet( "sample_metamorphic_region_id, sample_metamorphic_region" )

    def metamorphic_grade_facet( self ) :
        """ Return list of metamorphic grades for the given query. """
        return self.get_facet( "sample_metamorphic_grade_id, sample_metamorphic_grade" )

    def publication_facet( self ) :
        """ Return all publication info in a single facet. """
        return self.get_facet( "publication_id, author" )

    def get_selection ( self, field, value_set ) :
        """ Assumes the values are integers corresponding to ids,
            and the field is the name of an attribute given as a string.
            Example: 'rock_type_id' [1,2,3]
        """

        where_segment = ""
        params = {}
        if len(value_set) == 0:
            return ("", {})
        elif len(value_set) == 1:
            params[field] = str(value_set[0])
            return (" and " + field + " = %(" + field + ")s ", \
                        params)
        else: # more than 1 value in the set
            params[field] = ""
            where_segment = " and (" + field + " in (%(" + field + ")s)) "
            for item in value_set:
                params[field] += str(item) + ","
            params[field] = params[field].strip(",") 
        return (where_segment, params)

    def merge( self, query_str, params, (q,p)):
        query_str += q
        for key in p:
            params[key] = p[key]
        return query_str
        
    def get_where ( self ) :
        """ Constructs the WHERE clause for the current query object
            containing all specified conditions.

        """
        params = {}
        query_str = "WHERE public_data = 'Y' "
        if self.conditions_set:
            query_str = self.merge( \
                query_str, params,\
                    self.get_selection('rock_type_id', self.rock_type_selections))
            query_str = self.merge( \
                query_str, params,\
                    self.get_selection('country', self.country_selections))

            query_str = self.merge( \
                query_str, params,\
                    self.get_selection('owner_id', self.owner_id_selections))

            query_str = self.merge( \
                query_str, params,\
                    self.get_selection('sample_mineral_id', self.mineral_id_selections))

            query_str = self.merge( \
                query_str, params,\
                    self.get_selection('sample_region_id', self.region_id_selections))

            query_str = self.merge( \
                query_str, params,\
                    self.get_selection('sample_metamorphic_grade_id',\
                                           self.metamorphic_grade_id_selections))
            query_str = self.merge( \
                query_str, params,\
                    self.get_selection('sample_metamorphic_region_id',\
                                           self.metamorphic_region_id_selections))

            query_str = self.merge( \
                query_str, params,\
                    self.get_selection('publication_id',\
                                           self.publication_id_selections))

        return (query_str + " ", params)


    def __str__ ( self ) :
        return self.get_main()

    def get_main_brief ( self, limit=None ) :
        (where_str,params) = self.get_where() 
        attributes = " sample_id, sample_number, rock_type_name, "\
            "owner_name, latitude, longitude, current_location " 
        query_str =\
            "SELECT " + attributes + \
            "FROM  " + self.get_view_name() + " " + where_str + \
            "GROUP BY" + attributes
        if limit != None:
            query_str += " LIMIT " + str(limit)
        return query_str %params

#comma after current_location
    def get_main ( self, limit=None ) :
        (where_str,params) = self.get_where() 
        attributes = " sample_id, sample_number, rock_type_name, " + \
            "owner_name, latitude, longitude, current_location, " + \
            "num_subsamples, num_chemical_analyses, num_images "

        query_str =\
            "SELECT " + attributes + \
            "FROM  " + self.get_view_name() + ",sample_counts_view " +  \
            where_str + " AND sample_id = count_sample_id "\
            "GROUP BY" + attributes
        if limit != None:
            query_str += " LIMIT " + str(limit)
        return query_str %params

    def get_count ( self ) :
        (where_str,params) = self.get_where() 
        query_str =\
            "SELECT count(DISTINCT sample_id) " \
            "FROM  " + self.get_view_name() + " " + where_str 
        return query_str %params

if __name__ == '__main__':
    q = SampleQuery()

    print str(q)

    p = SampleQuery(rock_type=[1,2], country=["'United States'"], owner_id=[4,5,-1], \
                       mineral_id = [-1], region_id = [], publication_id = [1,2,3] ) 

    '''
    print str(p)

    r = SampleQuery(mineral_id = [-1] ) 

    print str(r)

    
    print ""

    print q.owner_facet()

    print p.owner_facet()
    print p.rock_type_facet()
    print p.country_facet()
    print p.mineral_facet()
    print p.region_facet()
    print p.publication_facet()

    print "********"
    print p.metamorphic_region_facet()

    print "*********"
    print p.metamorphic_grade_facet()

    print "*********"
    print p.publication_facet()

    print "@@@@@@@@@@@@@"
    q = SampleQuery()


    print q.get_count()

    print q.get_main()

    print q.get_main(10)'''

    print q.get_main_brief()
