from rest_framework import permissions

class IsOwnerOrProjectMember(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        return True
        if request.method in ['HEAD', 'OPTIONS']:            
            return True

        return False
