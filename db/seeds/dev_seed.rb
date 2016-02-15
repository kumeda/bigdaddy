# city1 = City.create(name: 'San Jose')
# city2 = City.create(name: 'Sunnyvale')
# city3 = City.create(name: 'Mountain View')
#
# spot1 = Spot.create(city: city1, name: 'in and out', yelp_url: '/#')
# spot2 = Spot.create(city: city2, name: 'fish market', yelp_url: '/#')
# spot3 = Spot.create(city: city3, name: 'sushi', yelp_url: '/#')
# spot4 = Spot.create(city: city3, name: 'pizza', yelp_url: '/#')
# spot5 = Spot.create(city: city3, name: 'cafe', yelp_url: '/#')
# spot6 = Spot.create(city: city3, name: 'cake', yelp_url: '/#')
#
# user1 = User.create(login_id: 'hiro', password: 'hiro', name: 'hiro', icon_image: '/images/dev-hiro.png', description: '在住半年 ラーメン店店主')
# user2 = User.create(login_id: 'taku', password: 'taku', name: 'taku', icon_image: '/images/dev-taku.png', description: '在住１年 駐在員')
# user3 = User.create(login_id: 'haruka', password: 'haruka', name: 'haruka', icon_image: '/images/dev-haruka.png', description: '在住半年 ラーメン店店主')
# user4 = User.create(login_id: 'mina', password: 'mina', name: 'mina', icon_image: '/images/dev-mina.png', description: '在住１年 駐在員')
#
# content = <<"EOS"
# 毎週月曜日はずっとハッピーアワー！
# なんと１日中ずっと牡蠣が１個1.5ドルなんです。やばくないっすか？
#
# 牡蠣をつまみにカリフォルニアビールをがぶ飲みして
# チップ込みで30ドルいきませんでした。
# 月に一回は行きたいおすすめレストランです♪
# EOS
#
# photos = {
#     spot1.name => "dev-hamburger2.png",
#     spot2.name => "dev-kaki2.png",
#     spot3.name => "dev-sushi2.png",
#     spot4.name => "dev-pizza2.png",
#     spot5.name => "S__18669580.jpg",
#     spot6.name => "S__18669579.jpg",
# }
#
# # for user in [user1, user2, user3, user4] do
# #   for spot in [spot1, spot2, spot3, spot4, spot5, spot6] do
# #     report = Report.new([
# #                                 {
# #                                     spot: spot,
# #                                     user: user,
# #                                     title: '今までで一番うまい',
# #                                     content: content,
# #                                     image: File.open(File.join(Rails.root, '/public/images/' + photos[spot.name]))
# #                                 }
# #                             ])
# #     # iu = ImageUploader.new!(report, :image)
# #     # iu.store!(File.open(File.join(Rails.root, '/images/' + photos[spot.name])))
# #     # report.image << iu
# #     report.save!
# #   end
# # end