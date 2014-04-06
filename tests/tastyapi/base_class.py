from django.contrib.auth.models import User as AuthUser
from tastypie.test import ResourceTestCase, TestApiClient
from tastypie.models import ApiKey
from tastyapi.models import User, AuthUser, get_public_groups
import nose.tools as nt

client = TestApiClient()

class TestSetUp(ResourceTestCase):
    fixtures = ['auth_users.json', 'users.json']

    def setUp(self):
        super(TestSetUp, self).setUp()
        auth_user = AuthUser.objects.get(pk = 1)
        ApiKey.objects.create(user = auth_user)
        self.user = User.objects.get(pk = 1)
        self.user.manual_verify()
        self.user.auto_verify(confirmation_code=None)

        auth_user = AuthUser.objects.get(pk = 2)
        ApiKey.objects.create(user = auth_user)
        user = User.objects.get(pk = 2)
        user.manual_verify()
        self.user.auto_verify(confirmation_code=None)

        # A user who doesn't have their own personal group
        auth_user = AuthUser.objects.get(pk = 3)
        ApiKey.objects.create(user = auth_user)

    def get_credentials(self, user_id = 1):
        auth_user = AuthUser.objects.get(pk = user_id)
        return "ApiKey {0}:{1}".format(auth_user.username,
                                       ApiKey.objects.get(user=auth_user).key)

    def test_valid_registration_sibel(self):
        nt.assert_equal(len(self.user.django_user.groups.all()), 2)
        personal_group = self.user.django_user.groups.all()[0]
        public_group = self.user.django_user.groups.all()[1]
        public_groups = get_public_groups()
        nt.assert_equal("user_group_sibel", personal_group.name)
        nt.assert_in(public_group, public_groups)
