from django.urls import path
import slots.views

urlpatterns = [
    path('',slots.views.SlotListAPIView.as_view(),name='slot_list'),
    path('<int:slot_id>/book/',slots.views.BookSlotCreateAPIView.as_view(),name='book_slot')
]
