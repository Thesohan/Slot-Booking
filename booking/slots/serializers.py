from rest_framework import serializers
from .models import BookSlot,Slot


class SlotSerializer(serializers.ModelSerializer):
     class Meta:
        model = Slot
        fields = ["id", "start_time", "end_time","available_seat"]
        read_only_fields = ("id","start_time","end_time","available_seat")


class BookSlotSerializer(serializers.ModelSerializer):
     start_time  = serializers.TimeField(source='slot.start_time')
     end_time  = serializers.TimeField(source='slot.end_time')

     class Meta:
        model = BookSlot
        fields = ["id","start_time", "end_time"]
        read_only_fields = ("id","start_time","end_time")
