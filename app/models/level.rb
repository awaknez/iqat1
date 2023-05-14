class Level < ApplicationRecord
  has_many :questions

  def self.select_level(session, params)
    # 難易度をパラムスから取得してモデルに渡す
    if params[:level].blank?
      # Levelモデルからカラム「id」の値だけを取得し、セッションに格納する（これで全ての分野のidを取得できる）
      level_ids = Level.pluck(:id)
      session[:selected_level_ids] << level_ids
    else
      # 選択された難易度をparamsから受け取り、セッションに格納する
      level_ids = params[:level][:level_ids].reject(&:empty?)
      if !session[:selected_level_ids].include?(level_ids)
        session[:selected_level_ids] << level_ids
      end
    end
    return level_ids
  end

  def self.select_level_forPrint(params)
    # 難易度をパラムスから取得してモデルに渡す
    if params[:level].blank?
      # Levelモデルからカラム「id」の値だけを取得し、セッションに格納する（これで全ての分野のidを取得できる）
      level_ids = Level.pluck(:id)
    else
      # 選択された難易度をparamsから受け取り、セッションに格納する
      level_ids = params[:level][:level_ids].reject(&:empty?)
    end
    return level_ids
  end
end
