require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  ### initialize test data
  let!(:todos) { create_list(:todos, 10) }
  let(:todo_id) { todos.fist.id }

  # TEST SUITE FOR GET /todos
  describe 'GET /todos' do
    # make HHTP get request before each example
    before{ get '/todos'}

    it 'returns todos' do
      # Note 'json' is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # TEST SUITE FOR GET /todos/:id
  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(400)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  TEST SUITE FOR POST /todos
  describe 'POST /todos' do
    #valid payload
    let(:valid_attributes) {{ title: 'Learn Elm', created_by: '1'}}

    context 'when the request is valid' do
      before { post '/todos', params: valid_attributes}

      it 'creates a todo' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before {post '/todos', params: {title: 'Foobar'}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a valifation failure message' do
        expecy(response.body).to match(/Validation failed: Create by can't be blank/)
      end
    end
  end

  TEST SUITE FOR PUT /todos/:id
  describe 'PUT /todos/:id' do
    let(:valid_attributes) {{title: 'Shopping'}}

    context 'when the record exists' do
      before { put "todos/#{todo_id}", params: valid_attributes}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(resoinse).to have_http_status(204)
      end
    end
  end

  # TEST SUITE FOR DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todos_id}" }
  
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
