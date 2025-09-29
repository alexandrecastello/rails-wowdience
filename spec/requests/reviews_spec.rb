require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:review) { create(:review, user: user, event: event) }

  describe 'GET /reviews' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'returns http success' do
        get reviews_path
        expect(response).to have_http_status(:success)
      end

      it 'displays user reviews' do
        create(:review, user: user, event: event)
        get reviews_path
        expect(response.body).to include(event.name)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        get reviews_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /reviews/:id' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'returns http success' do
        get review_path(review.id)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        get review_path(review.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /reviews/new' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'redirects to step1' do
        get new_review_path
        expect(response).to redirect_to(new_review_step1_path)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        get new_review_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /reviews/step1' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'returns http success' do
        get new_review_step1_path
        expect(response).to have_http_status(:success)
      end

      it 'displays events list' do
        create_list(:event, 3)
        get new_review_step1_path
        expect(response.body).to include('form')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        get new_review_step1_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /reviews/step2' do
    context 'when user is authenticated' do
      before { sign_in user }

      context 'with existing event' do
        it 'returns http success' do
          get new_review_step2_path, params: { event_id: event.id }
          expect(response).to have_http_status(:success)
        end

        it 'displays the review form' do
          get new_review_step2_path, params: { event_id: event.id }
          expect(response.body).to include('form')
        end
      end

      context 'with new event parameters' do
        let(:event_attributes) do
          {
            event: {
              name: 'New Event',
              start_date: 1.week.from_now,
              description: 'Test description',
              location_id: event.location.id
            }
          }
        end

        it 'creates a new event and shows review form' do
          expect {
            get new_review_step2_path, params: event_attributes
          }.to change(Event, :count).by(1)
        end
      end

      context 'without event parameters' do
        it 'redirects to step1 with alert' do
          get new_review_step2_path
          expect(response).to redirect_to(new_review_step1_path)
          expect(flash[:alert]).to eq('Por favor, selecione ou crie um evento.')
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        get new_review_step2_path, params: { event_id: event.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /reviews/create_step2' do
    let(:valid_attributes) do
      {
        review: {
          rating: 4.5,
          comment: 'Great event!',
          event_id: event.id
        }
      }
    end

    context 'when user is authenticated' do
      before { sign_in user }

      context 'with valid parameters' do
        it 'creates a new review' do
          expect {
            post create_review_step2_path, params: valid_attributes
          }.to change(Review, :count).by(1)
        end

        it 'redirects to the review' do
          post create_review_step2_path, params: valid_attributes
          expect(response).to redirect_to(Review.last)
        end
      end

      context 'with invalid parameters' do
        let(:invalid_attributes) do
          {
            review: {
              rating: 6.0, # Invalid rating
              comment: 'Great event!',
              event_id: event.id
            }
          }
        end

        it 'does not create a new review' do
          expect {
            post create_review_step2_path, params: invalid_attributes
          }.not_to change(Review, :count)
        end

        it 'renders step2 template' do
          post create_review_step2_path, params: invalid_attributes
          expect(response).to render_template(:step2)
        end
      end

      context 'without event_id' do
        let(:attributes_without_event) do
          {
            review: {
              rating: 4.5,
              comment: 'Great event!'
            }
          }
        end

        it 'redirects to step1 with alert' do
          post create_review_step2_path, params: attributes_without_event
          expect(response).to redirect_to(new_review_step1_path)
          expect(flash[:alert]).to eq('Evento não encontrado. Tente novamente.')
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        post create_review_step2_path, params: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /reviews' do
    let(:valid_attributes) do
      {
        review: {
          rating: 4.5,
          comment: 'Great event!',
          event_id: event.id
        }
      }
    end

    context 'when user is authenticated' do
      before { sign_in user }

      context 'with valid parameters' do
        it 'creates a new review' do
          expect {
            post reviews_path, params: valid_attributes
          }.to change(Review, :count).by(1)
        end

        it 'redirects to the event' do
          post reviews_path, params: valid_attributes
          expect(response).to redirect_to(event_path(event))
        end
      end

      context 'with invalid parameters' do
        let(:invalid_attributes) do
          {
            review: {
              rating: 6.0, # Invalid rating
              comment: 'Great event!',
              event_id: event.id
            }
          }
        end

        it 'does not create a new review' do
          expect {
            post reviews_path, params: invalid_attributes
          }.not_to change(Review, :count)
        end

        it 'redirects to the event with alert' do
          post reviews_path, params: invalid_attributes
          expect(response).to redirect_to(event_path(event))
          expect(flash[:alert]).to eq('Houve um erro ao criar a avaliação.')
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        post reviews_path, params: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /reviews/:id/edit' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'returns http success' do
        get edit_review_path(review.id)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        get edit_review_path(review.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH /reviews/:id' do
    let(:update_attributes) do
      {
        review: {
          rating: 5.0,
          comment: 'Updated comment'
        }
      }
    end

    context 'when user is authenticated' do
      before { sign_in user }

      context 'with valid parameters' do
        it 'updates the review' do
          patch review_path(review.id), params: update_attributes
          review.reload
          expect(review.rating).to eq(5.0)
          expect(review.comment).to eq('Updated comment')
        end

        it 'redirects to the review' do
          patch review_path(review.id), params: update_attributes
          expect(response).to redirect_to(review)
        end
      end

      context 'with invalid parameters' do
        let(:invalid_update_attributes) do
          {
            review: {
              rating: 6.0, # Invalid rating
              comment: 'Updated comment'
            }
          }
        end

        it 'renders the edit template' do
          patch review_path(review.id), params: invalid_update_attributes
          expect(response).to render_template(:edit)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        patch review_path(review.id), params: update_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /reviews/:id' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'destroys the review' do
        review_to_delete = create(:review, user: user, event: event)
        expect {
          delete review_path(review_to_delete.id)
        }.to change(Review, :count).by(-1)
      end

      it 'redirects to reviews index' do
        delete review_path(review.id)
        expect(response).to redirect_to(reviews_path)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        delete review_path(review.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
