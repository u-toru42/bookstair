require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  before { sign_in(user) }

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new book' do
        expect {
          post :create, params: { book: attributes_for(:book) }
        }.to change(Book, :count).by(1)
      end

      it 'redirects to the created book' do
        post :create, params: { book: attributes_for(:book) }
        expect(response).to redirect_to(Book.last)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the book' do
      book_to_delete = create(:book)
      expect {
        delete :destroy, params: { isbn: book_to_delete.isbn }
      }.to change(Book, :count).by(-1)
    end

    it 'redirects to books index' do
      delete :destroy, params: { isbn: book.isbn }
      expect(response).to redirect_to(books_path)
    end
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

end
