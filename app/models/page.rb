class Page < ActiveRecord::Base
  self.table_name = 'page'
  self.primary_key = 'page_id'
  # has_many :pagelinks, class_name: 'Pagelink', foreign_key: 'pl_from'

  def pagelinks_by_title
    Pagelink.where(pl_title: self.page_title)
  end

  # def self.pagelinks_by_title
  #   find_by_sql "SELECT  `page`.* FROM `page` INNER JOIN `pagelinks` ON `pagelinks`.`pl_title` = `page`.`page_title`  ORDER BY `page`.`page_id` ASC"
  # end

end
