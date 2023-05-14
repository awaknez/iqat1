class Genre < ApplicationRecord
  has_many :questions

  def self.select_genre(session, params)
    # 出題範囲が選択されているか否かで条件分岐
    # 出題範囲が選択されていない場合
    if params[:genre].blank?
      # Genreモデルからカラム「id」の値だけを取得し、セッションに格納する（これで全ての分野のidを取得できる）
      genre_ids = Genre.pluck(:id)
      session[:selected_genre_ids] << genre_ids
    else
      # 選択された分野をparamsから受け取り、セッションに格納する
      genre_ids = params[:genre][:genre_ids].reject(&:empty?)
      if !session[:selected_genre_ids].include?(genre_ids)
        session[:selected_genre_ids] << genre_ids
      end
    end
    return genre_ids
  end

  def self.select_genre_forPrint(params)
    # 出題範囲が選択されているか否かで条件分岐
    # 出題範囲が選択されていない場合
    if params[:genre].blank?
      # Genreモデルからカラム「id」の値だけを取得し、セッションに格納する（これで全ての分野のidを取得できる）
      genre_ids = Genre.pluck(:id)
    else
      # 選択された分野をparamsから受け取り、セッションに格納する
      genre_ids = params[:genre][:genre_ids].reject(&:empty?)
    end
    return genre_ids
  end
end
