import json
import base64
from django.http import HttpResponse, HttpResponseNotFound
from django.http import HttpResponseForbidden
from django.db import transaction
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.hashers import make_password
from .models import User, generate_confirmation_code

from metpetdb import settings
from django.core.mail import EmailMultiAlternatives
from django.template.loader import get_template
from django.template import Context

@csrf_exempt
@transaction.commit_on_success
def register(request):
    json_data = json.loads(request.body)
    print(json_data)

    try:
        User.objects.get(email=json_data['email'])
        data = {
            'result': 'failed',
            'message': 'email is already taken'
        }
        return HttpResponseForbidden(json.dumps(data),
                                     mimetype='application/json')
    except:
        allowed_params = ["name", "email", "address", "city", "password",
                          "province", "country", "postal_code"]

        user = User()
        user.version = 1
        for param, value in json_data.iteritems():
            if param in allowed_params:
                setattr(user, param, value)
    user.password = bytearray(base64.b64encode(make_password(
                                                       json_data['password'])))
    user.enabled = 'N'
    user.contributor_enabled = 'N'
    user.confirmation_code = ''
    user.contributor_code = ''
    user.django_user = None
    user.save()
    data = {
        'result': 'success',
        'message': 'user registration successful',
        'email': user.email,
        'api_key': user.django_user.api_key.key
    }
    return HttpResponse(json.dumps(data), mimetype='application/json')

@csrf_exempt
def authenticate(request):
    json_data = json.loads(request.body)
    print(json_data['password'])
    try:
        user = User.objects.get(email=json_data['email'])
    except:
        data = {
            'result': 'failed',
            'message': 'invalid email address'
        }
        return HttpResponseForbidden(json.dumps(data),
                                     mimetype='application/json')
    if user.django_user.check_password(json_data['password']):
        data = {
            'result': 'success',
            'email': user.email,
            'api_key': user.django_user.api_key.key
        }
        return HttpResponse(json.dumps(data), mimetype='application/json')
    else:
        data = {
            'status': 'failed',
            'message': 'authentication failed'
        }
        return HttpResponseForbidden(json.dumps(data),
                                     mimetype='application/json')

@transaction.commit_on_success
def confirm(request, conf_code):
    try:
        user = User.objects.get(confirmation_code=conf_code)
    except User.DoesNotExist:
        return HttpResponseNotFound("The confirmation code is invalid.")

    if user.enabled == 'Y':
        return HttpResponseForbidden("This account has already been confirmed")

    if user.auto_verify(conf_code):
        return HttpResponse("Thank you for confirming your email address!")
    else:
        return HttpResponse("Unable to confirm your email address.")

@transaction.commit_on_success
def request_contributor_access(request):
    try:
        user = User.objects.get(email=request.GET['email'])
    except:
        return HttpResponseNotFound("No user with that email address exists in our system.")

    if user.enabled == "N":
        return HttpResponseForbidden("Please confirm your email address first.")

    if user.contributor_code == '':
        return HttpResponseForbidden("You have already requested access.")

    if user.contributor_enabled == 'Y':
        return HttpResponseForbidden("This user is already a contributor")

    allowed_params = ['professional_url', 'research_interests',
                      'institution', 'reference_email']

    for param, value in request.GET.iteritems():
        if param in allowed_params:
            setattr(user, param, value)

    user.contributor_code = generate_confirmation_code(user.email)
    user.save()

    plaintext = get_template('request_contributor_access.txt')
    html      = get_template('request_contributor_access.html')

    d = Context({ 'name': 'Krishna Aradhi',
                  'user': user,
                  'host_name': settings.HOST_NAME })

    subject, from_email, to = 'hello', 'krishna@aradhi.me', 'krishna@aradhi.me'
    text_content = plaintext.render(d)
    html_content = html.render(d)
    msg = EmailMultiAlternatives(subject, text_content, from_email, [to])
    msg.attach_alternative(html_content, "text/html")
    msg.send()
    return HttpResponse("Your request to be added as a contributor has been submitted")

@transaction.commit_on_success
def grant_contributor_access(request, contributor_code):
    try:
        user = User.objects.get(contributor_code=contributor_code)
    except User.DoesNotExist:
        return HttpResponseNotFound("The contributor code is invalid.")

    if user.contributor_enabled == 'Y':
        return HttpResponseForbidden("This user is already a contributor.")

    if user.manual_verify():
        return HttpResponse("This user is now a contributor!")
    else:
        return HttpResponseForbidden("Unable to make this user a contributor")
