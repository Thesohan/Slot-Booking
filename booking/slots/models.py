from django.db import models
from django.contrib.auth.models import User
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import transaction
# Create your models here.

class TimestampedModel(models.Model):
    created_ts = models.DateTimeField(auto_now_add=True)
    updated_ts = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class AuditEnabledModel(TimestampedModel):
    updated_by = models.ForeignKey(
        User,
        null=True,
        blank=True,
        editable=False,
        related_name="+",
        on_delete=models.deletion.SET_NULL,
    )
    created_by = models.ForeignKey(
        User,
        null=True,
        blank=True,
        editable=False,
        related_name="+",
        on_delete=models.deletion.SET_NULL,
    )
    deleted = models.BooleanField(default=False)

    class Meta:
        abstract = True

class Slot(AuditEnabledModel):
     start_time = models.TimeField()
     end_time   = models.TimeField()
     available_seat = models.IntegerField(default=3,validators=[MinValueValidator(0),MaxValueValidator(3)])

     @classmethod
     def book_slot(cls, slot_id):
          with transaction.atomic():
               slot = (
                    cls.objects
                    .select_for_update(nowait=False)
                    .get(id=slot_id)
               )
               slot.available_seat -= 1
               slot.save()
          return BookSlot.objects.create(slot=slot)

     def save(self,*args,**kwargs):
          self.full_clean()
          super().save(*args, **kwargs)

class BookSlot(AuditEnabledModel):
     slot = models.ForeignKey(Slot,on_delete=models.CASCADE)

