import json
import datetime

class CustomJSONEncoder(json.JSONEncoder):
    """ http://stackoverflow.com/questions/455580/ """
    def default(self, obj):
        if isinstance(obj, datetime.datetime):
            return obj.isoformat()
        else:
            return super(CustomJSONEncoder, self).default(obj)
           
def dictfetchall(cursor):
    """ Returns all rows from a cursor as a list of dictionaries
        From https://docs.djangoproject.com/en/dev/topics/db/sql/#connections-and-cursors
    """
    
    desc = cursor.description
    
    rows = cursor.fetchall()

    if rows:
        return [
            dict(zip([col[0] for col in desc], row)) # unicode() ?
            for row in rows
        ]

    return []
    
def dictfetchone(cursor):
    """ Returns a row from a cursor as a dictionary """
    
    desc = cursor.description

    row = cursor.fetchone()
    if row:
    	return dict(zip([col[0] for col in desc], row)) # unicode() ?

    return {"error": "DNE"}
