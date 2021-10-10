from django.core.management.base import BaseCommand
from slots.models import Slot
from datetime import time
class Command(BaseCommand):
    help = 'Remove/Inserts the available slots'

    def handle(self, *args, **options):
         Slot.objects.all().delete()
         slots = []
         for i in range(6):
              slots.append(Slot(**{"start_time":time(hour=10+i),"end_time":time(hour=10+i+1)}))
         Slot.objects.bulk_create(slots)
