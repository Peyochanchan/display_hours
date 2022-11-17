require 'rails_helper'

RSpec.describe "Shops", type: :request do
  let(:shop) { FactoryBot.create(:shop_with_weekdays) }
  let(:attributes) { { name: 'Chez Malou' } }
  let(:shop_one) { instance_double(Shop) }

  before(:example) do
    @new_shop = Shop.new(name: 'The Bear')
  end

  describe '#Get' do
    context 'index' do
      before { get '/shops' }

      it { expect(response).to have_http_status(:success) }
      it { should render_template('index') }

      let(:new_shop) { Shop.new }
    end

    context 'show' do
      before { get "/shops/#{shop.id}" }

      it { expect(response).to have_http_status(:success) }
      it { should render_template('show') }
    end

    context 'new' do
      it '#new returns a success response' do
        get '/shops/new'
        expect(assigns[:shop]).to be_a(Shop)
        expect(response).to have_http_status(200)
      end
    end

    context 'edit' do
      it "render a successful response" do
        shop = Shop.create! attributes
        get edit_shop_url(shop)
        expect(response).to be_successful
      end
    end
  end

  describe "#Post" do
    it "creates a Shop" do
      post "/shops", params: { shop: attributes }
      expect(response).to redirect_to(assigns(:shop))
      follow_redirect!
      expect(response.body).to include("shop was successfully created.")
    end

    it 'expect to create 7 days with shop\'s creation' do
      expect(shop.opening_days.length).to eql(7)
    end
  end

  describe "#Patch" do
    it "updates the shop and redirects" do
      allow(shop).to receive(:name).and_return('Josiane')
      expect(shop.name).to eq("Josiane")
    end
  end

  describe "#Delete" do
    before :each do
      @shop = Shop.create! attributes
    end

    it "destroys the requested shop" do
      expect { delete(shop_url(@shop)) }.to change(Shop, :count).by(-1)
    end

    it "redirects to the shops list" do
      delete shop_url(@shop)
      expect(response).to redirect_to(shops_url)
    end

    it 'includes "shop was successfully destroyed!"' do
      delete(shop_url(@shop))
      follow_redirect!
      expect(response.body).to include("shop was successfully destroyed.")
    end
  end
end
