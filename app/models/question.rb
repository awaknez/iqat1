class Question < ApplicationRecord
  has_many :choices
  has_one :answer
  belongs_to :genre
  belongs_to :level

  def self.selectQuestion(session)
    if session[:question_range] .present?
      question = Question.where(id: session[:question_range]).where.not(id: session[:asked_question_ids]).order("RANDOM()").first
    else
      #当メソッドを呼び出す際には最低1回はask~resultメソッドを実行している。そのため、セッションを参考にして分野を指定しながら出題済みの問題を避けて次の問題（インスタンス）を取得できる。
      question = Question.where(genre_id: session[:selected_genre_ids],level_id: session[:selected_level_ids]).where.not(id: session[:asked_question_ids]).order("RANDOM()").first
    end
    return question
  end


  def self.calcCorrectRate(asked_question_count, correct_counts)
    # to_fは浮動小数（float）への変換
    correct_rate = ((correct_counts.to_f / asked_question_count.to_f).to_f * 100).round(1)
    # binding.pry
    return correct_rate
  end

  def self.selectQuestionByOrder(question_order, genre_ids, level_ids, question_count)
    # 出題形式が「ランダム」の場合
    if question_order == 1
      questions = Question.where(genre_id: genre_ids, level_id: level_ids).order("RANDOM()").limit(question_count)
    # 出題形式が「番号順」の場合
    elsif question_order == 2
      questions = Question.where(genre_id: genre_ids, level_id: level_ids).order(id: "ASC").limit(question_count)
    end
    return questions
  end

  def self.calcQuestionsCounts

    question_count_array = []

    # 問題総数を格納するハッシュ
    all_count_hash = {}
    # questionレコードの総数を取得し、格納する
    question_count_all = Question.where(genre_id: 1..4).count
    all_count_hash["all_counts:"] = question_count_all

    question_count_array << all_count_hash

    # ジャンルごとの質問数を格納するハッシュ
    genre_count_hash = {}
    
    # ジャンルごとの質問数を取得し、ハッシュに格納する
    Genre.all.each do |genre|
      question_count_genre = Question.where(genre_id: genre.id).count
      genre_count_hash["genre_id:#{genre.id}"] = question_count_genre
    end
    
    # ハッシュを配列に追加する
    question_count_array << genre_count_hash
    
    # レベルごとの質問数を格納するハッシュ
    level_count_hash = {}
    
    # レベルごとの質問数を取得し、ハッシュに格納する
    Level.all.each do |level|
      question_count_level = Question.where(level_id: level.id).count
      level_count_hash["level:#{level.id}"] = question_count_level
    end
    
    # ハッシュを配列に追加する
    question_count_array << level_count_hash

    return question_count_array

  end

end
