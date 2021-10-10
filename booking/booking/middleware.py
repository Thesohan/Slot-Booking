from django.utils.deprecation import MiddlewareMixin
from django.http import JsonResponse
from django.core.exceptions import ValidationError

class ValidationExceptionMiddleware(MiddlewareMixin):

    def process_exception(self, request, exception):
        if isinstance(exception, ValidationError):
            return JsonResponse({"error": str(exception)}, status=400)