from rest_framework import generics
from .serializers import SlotSerializer,BookSlotSerializer
from .models import BookSlot,Slot
from django.shortcuts import get_object_or_404
from rest_framework.response import Response
from rest_framework import status
# Create your views here.

class SlotListAPIView(generics.ListAPIView):
     queryset = Slot.objects.all().order_by('-available_seat')
     serializer_class = SlotSerializer


class BookSlotCreateAPIView(generics.CreateAPIView):
     serializer_class = BookSlotSerializer


     def post(self, request, slot_id,*args, **kwargs):
          _ = get_object_or_404(Slot,pk=slot_id)
          booked_slot = Slot.book_slot(slot_id=slot_id)
          return Response(BookSlotSerializer(instance=booked_slot).data, status=status.HTTP_201_CREATED)





