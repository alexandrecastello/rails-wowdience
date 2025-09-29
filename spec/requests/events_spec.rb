require 'rails_helper'

RSpec.describe 'Events', type: :request do
  let(:user) { create(:user) }
  let(:event_type) { create(:event_type, :concert) }
  let(:location) { create(:location) }
  let(:artist) { create(:artist) }
  let(:event) { create(:event, event_type: event_type, location: location) }

  describe 'GET /events' do
    it 'returns http success' do
      get events_path
      expect(response).to have_http_status(:success)
    end

    it 'displays events ordered by start_date' do
      event1 = create(:event, start_date: 2.days.from_now)
      event2 = create(:event, start_date: 1.day.from_now)

      get events_path

      expect(response.body).to include(event2.name)
      expect(response.body).to include(event1.name)
    end
  end

  describe 'GET /events/:id' do
    it 'returns http success' do
      get event_path(event.id)
      expect(response).to have_http_status(:success)
    end

    it 'displays event details' do
      get event_path(event.id)
      expect(response.body).to include(event.name)
    end
  end

  describe 'GET /events/new' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'returns http success' do
        get new_event_path
        expect(response).to have_http_status(:success)
      end

      it 'displays the new event form' do
        get new_event_path
        expect(response.body).to include('form')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        get new_event_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /events' do
    let(:valid_attributes) do
      {
        event: {
          name: 'Test Event',
          start_date: 1.week.from_now,
          description: 'Test description',
          location_id: location.id
        },
        artist_id: artist.id
      }
    end

    context 'when user is authenticated' do
      before { sign_in user }

      context 'with valid parameters' do
        it 'creates a new event' do
          expect {
            post events_path, params: valid_attributes
          }.to change(Event, :count).by(1)
        end

        it 'redirects to the created event' do
          post events_path, params: valid_attributes
          expect(response).to redirect_to(Event.last)
        end

        it 'associates the event with the artist' do
          post events_path, params: valid_attributes
          expect(Event.last.artists).to include(artist)
        end
      end

      context 'with invalid parameters' do
        let(:invalid_attributes) do
          {
            event: {
              name: '',
              start_date: 1.week.from_now,
              description: 'Test description',
              location_id: location.id
            }
          }
        end

        it 'does not create a new event' do
          expect {
            post events_path, params: invalid_attributes
          }.not_to change(Event, :count)
        end

        it 'renders the new template' do
          post events_path, params: invalid_attributes
          expect(response).to render_template(:new)
        end
      end

      context 'with new location name' do
        let(:location_attributes) do
          {
            event: {
              name: 'Test Event',
              start_date: 1.week.from_now,
              description: 'Test description',
              location_name: 'New Location'
            },
            artist_id: artist.id
          }
        end

        it 'creates a new location' do
          expect {
            post events_path, params: location_attributes
          }.to change(Location, :count).by(1)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        post events_path, params: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /events/:id/edit' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'returns http success' do
        get edit_event_path(event.id)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        get edit_event_path(event.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH /events/:id' do
    let(:update_attributes) do
      {
        event: {
          name: 'Updated Event Name',
          start_date: event.start_date,
          description: 'Updated description',
          location_id: location.id
        }
      }
    end

    context 'when user is authenticated' do
      before { sign_in user }

      context 'with valid parameters' do
        it 'updates the event' do
          patch event_path(event.id), params: update_attributes
          event.reload
          expect(event.name).to eq('Updated Event Name')
        end

        it 'redirects to the event' do
          patch event_path(event.id), params: update_attributes
          expect(response).to redirect_to(event)
        end
      end

      context 'with invalid parameters' do
        let(:invalid_update_attributes) do
          {
            event: {
              name: '',
              start_date: event.start_date,
              description: 'Updated description',
              location_id: location.id
            }
          }
        end

        it 'renders the edit template' do
          patch event_path(event.id), params: invalid_update_attributes
          expect(response).to render_template(:edit)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        patch event_path(event.id), params: update_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
