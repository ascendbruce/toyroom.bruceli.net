# USAGE
#
# 1. copy the latest label names from the Archive page, format and paste into the tags array below
# 2. Run `ruby scripts/refresh_labels.rb`

require "jekyll/utils"

tags = %w[
  學習成功部落格
  小技巧
  聽演講心得
  雜項
  讀書心得
  公告
  作品
  心情日記
  成功的觀念
  翻譯國外好文
  商管、創業
  個人發展
  教育
  全人-感情
  領導
  全人-心智
  全人-心靈
  輔助工具
  全人-健康
  夢境
  遊記
  嘉言精選
  食記
  我覺得不錯的終極用品
  怎麼唸
  Mac
  有趣好笑
  Ubuntu
  linux
  ror
  音樂
  了解新知與探究常識
  git
  rails
  ruby
  經驗學習
  mysql
  iphone
  mac
  Sublime
  career
  pow
  Techbang
  productivity
  雜想
]

Dir.foreach("_labels") do |f|
  fn = File.join("_labels", f)
  File.delete(fn) if f != '.' && f != '..'
end

tags.each do |tag|
  tag_slug = Jekyll::Utils.slugify(tag, mode: "raw")
  File.open("_labels/#{tag_slug}.md", "wb") do |file|
    file << <<~TEXT
      ---
      layout: label_page
      tag-name: #{tag}
      ---
    TEXT
  end
end
