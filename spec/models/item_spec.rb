require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '内容に問題がない場合' do
    it '全て正しく入力されていれば登録できる' do
      expect(@item).to be_valid
    end

    it 'gradeが1でも登録できる' do
      @item.grade_id = 1
      expect(@item).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'imageが空の場合は登録できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it 'nameが空の場合は登録できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it 'nameは40字以上の場合は登録できない' do
      @item.name = '私が大切に育ててきたカボチャ、私が大切に育ててきた大根、私が大切に育ててきたジャガイモ、私が大切に育ててきたトマト'
      @item.valid?
      expect(@item.errors.full_messages).to include('Name is too long (maximum is 40 characters)')
    end

    it 'introduceが空の場合は登録できない' do
      @item.introduce = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Introduce can't be blank")
    end

    it 'introduceが1000字以上の場合は登録できない' do
      @item.introduce = "スーツケースを格安で購入する場合、皆さんならまずスーツケースのどの部分を見ますか？
      スーツケースを選ぶ際に抑えておきたいポイントは「デザイン」「重さ」「大きさ」「ブランド」の4つです。
      格安で購入するためにはその4つのポイントのどの点を妥協するか、ということになります。まずは、4つの
      ポイントをそれぞれ説明しましょう。
      1つ目のデザインに関してです。正直デザインに関しては、人それぞれなので、何がよい、悪いを一概に判断する
      事は出来ません。しかしデザインに関しては大きく2種類に分類する事が出来ます。それは閉じる部分がチャック
      式になってるかなっていないかです。これは容量とも関係する部分ですが、ここはデザインの大きな要素です。
      カチッとしたデザインが好きであればチャックは選びませんが、カジュアルなイメージであれば、チャック式
      ということになるでしょう。色や柄は自分の好きなものを選ぶのが、愛着も沸いてよいと思いますが、一番最初
      に見るポイントとしてまずここは覚えておきたいところです。
      2つ目は重さです。重さは非常に重要です。なぜなら、飛行機には預け入れ荷物の重量制限があり、これを
      オーバーすると超過料金を支払う必要があるためです多くの空港会社は20キロ前後が制限になっています。
      それを逆算して大きさにもよりますが、大きいものでも4キロ程度の軽めのスーツケースを買うのが得策かと
      思います。但し、大きくても軽いスーツケースは比較的値段が高いものが多く、格安で購入したいニーズには
      合わないかもしれません。
      3つ目は大きさです。重さと連動する点でもありますが、容量は大きく分けると5種類程度に分けられます。
      小さいものから、SS、S、M、L、LLです。スーツケースを必要とする時期や旅先の滞在期間に応じて購入する
      ようにしましょう。当然、大きくなればなるほど、値段も高くなります。
      4つ目はブランドです。正直高いスーツケースは本当に高いです。100万を超えるようなスーツケースも
      ざらにあります。良いブランドであれば当然機能性やデザイン性には優れていますが、格安で購入するので
      あれば、あまり名の知られていないブランドのスーツケースを買うことをおすすめします。但し長い目で見ると、 頻繁に使うのであればよいもの1つ買って長く使ったほうが、コスパがよいかも知れません。
      以上のポイントから、何を妥協すべきか、妥協できるのかを考えて購入すると、
      自分にあったお得な格安スーツケースが購入できるでしょう。（1031文字）"
      @item.valid?
      expect(@item.errors.full_messages).to include('Introduce is too long (maximum is 1000 characters)')
    end

    it 'size_idが1の場合は登録できない' do
      @item.size_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Size can't be blank")
    end

    it 'category_idが1の場合は登録できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it 'status_idが1の場合は登録できない' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Status can't be blank")
    end

    it 'pay_for_shopping_idが1の場合は登録できない' do
      @item.pay_for_shopping_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Pay for shopping can't be blank")
    end

    it 'delivery_area_idが1の場合は登録できない' do
      @item.delivery_area_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery area can't be blank")
    end

    it 'day_to_ship_idが1の場合は登録できない' do
      @item.day_to_ship_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Day to ship can't be blank")
    end

    it 'priceが空の場合は登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it 'priceが299円以下の場合は登録できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is out of setting range')
    end

    it 'priceが10,000,000円以上の場合は登録できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is out of setting range')
    end

    it 'priceは半角英字の場合は登録できない' do
      @item.price = 'aaaaa'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Input half-width characters.')
    end

    it 'priceは半角カタカナの場合は登録できない' do
      @item.price = 'ﾋﾗﾀ'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Input half-width characters.')
    end

    it 'priceは全角カタカナの場合は登録できない' do
      @item.price = 'ヒラタ'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Input half-width characters.')
    end

    it 'priceは全角ひらがなの場合は登録できない' do
      @item.price = 'ひらた'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Input half-width characters.')
    end

    it 'priceは全角英字の場合は登録できない' do
      @item.price = "\bｓｓｓ"
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Input half-width characters.')
    end

    it 'priceは全角数字の場合は登録できない' do
      @item.price = '１１１１１'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Input half-width characters.')
    end

    it 'userが紐付いていなければ登録できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
    end
  end
end
