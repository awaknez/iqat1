class QuestionsController < ApplicationController
  before_action :renderHTML, only: [:index, :ask, :next_question, :retry, :print]

  def index
  end


  def choose
    reset_session
    @genres = Genre.all
    @levels = Level.all
    # MySQLなら以下
    # @question = Question.where(level_id: 1).order("RAND()").first
    # PostageSQLなら以下
    @question = Question.where(level_id: 1).order("RANDOM()").first
    @answer = Answer.find(@question.id)
    @question_count_array = Question.calcQuestionsCounts
  end


  def ask
			initialize_session
			genre_ids = Genre.select_genre(session, params)
			level_ids = Level.select_level(session, params)

      # 出題数を格納
      @question_nums = Question.where(genre_id: genre_ids, level_id: level_ids).count
      session[:question_nums] << @question_nums

      # genre_idsに入っている分野idと一致するインスタンスを1つ取得する
      # @question = Question.where(genre_id: genre_ids,level_id: level_ids).order("RAND()").first
      # PostageSQLなら以下
      @question = Question.where(genre_id: genre_ids,level_id: level_ids).order("RANDOM()").first

      if @question.present?
        # session[:asked_question_ids]に取得したインスタンスの問題idを格納する。
        if !session[:asked_question_ids].include?(@question.id)
          session[:asked_question_ids] << @question.id
        end

        #取得した問題インスタンスに付随する選択肢を取得する。
        # @choices = @question.choices.includes(:question).order("RAND()") #questionとアソシエーション関係なので（）の中にはカラム名ではなく関係のあるモデル名にする「_id」は不要
        # PostageSQLなら以下
        @choices = @question.choices.includes(:question).order("RANDOM()") 
        @answer = Answer.find(@question.id)
    
      else
        redirect_to root_path, alert: "出題できる問題がありません。"
      end
  end


  def check
    # 選択された値の正誤を判定
    choice = Choice.find(params[:choice_id])
    # q_idを読み取って、当該レコードを取得する
    question = Question.find(params[:question_id])
    if choice.is_answer
      result = true
      # 正答したら、問題番号を正答数計上セッションに追加する
      session[:correct_answers] << question.id
    else
      result = false
      # 誤答の場合、問題番号を不正解セッションに追加する
      session[:incorrect_answers] << question.id
    end
    # 正誤判定の結果をJSON形式で返す
    render json: { result: result }
  end

  
  def next_question
      session = request.session
			@question = Question.selectQuestion(session)
        # session[:asked_question_ids]に取得したインスタンスの問題idを追加格納する。
      if @question.present?
          session[:asked_question_ids] << @question.id
          # @choices = @question.choices.includes(:question).order("RAND()") #questionとアソシエーション関係なので（）の中にはカラム名ではなく関係のあるモデル名にする「_id」は不要
          # PostageSQL
          @choices = @question.choices.includes(:question).order("RANDOM()") 
          @answer = Answer.find(@question.id)

          if session[:question_nums].present?
            @question_nums = session[:question_nums]
          end
          
          # -1は出題数を調整するため
          @asked_question_count = count_asked_question
          @correct_counts = count_correct_counts

          # to_fは浮動小数（float）への変換
					
          @correct_rate = Question.calcCorrectRate(@asked_question_count, @correct_counts)          # 呼び出すビューファイルはaskアクションのビューファイル
          render :ask
      else
          redirect_to score_questions_path
      end 
  end

  def score
    #出題数を取得 セッション配列の1つ目の要素として格納されている値を取得するため[0]を使う
    @question_nums = session[:question_nums][0]
    # 正解数を取得
    @correct_counts = session[:correct_answers].length

    if @question_nums == 0
      render html: '<script>alert("おめでとうございます。全問正解したためトップページに戻ります。");window.location.href = "/";</script>'.html_safe
    end
  end

	def retry

      # セッションを調節し、間違えた問題を取得する
      incorrect_question_ids =  adjustSession
      # 出題数を格納
      @question_nums = incorrect_question_ids.length
      session[:question_nums] << @question_nums
      # 不正解問題のidでレコードを取得する
      # @question = Question.where(id: incorrect_question_ids).order("RAND()").first
      @question = Question.where(id: incorrect_question_ids).order("RANDOM()").first
      if @question.present?
          # 不正解問題のidを出題済みセッションに格納する
          session[:asked_question_ids] << @question.id
          @choices = @question.choices.includes(:question).order("RANDOM()") #questionとアソシエーション関係なので（）の中にはカラム名ではなく関係のあるモデル名にする「_id」は不要
          # @choices = @question.choices.includes(:question).order("RAND()") 
          @answer = Answer.find(@question.id)
          render :ask
      else
        redirect_to score_questions_path
      end 
    
  end


  # ここから問題印刷用のアクション

	def print
      # 出題数をパラムスより取得する
      question_count = params[:question_count].to_i
      
			genre_ids = Genre.select_genre_forPrint(params)
			level_ids = Level.select_level_forPrint(params)

      # 選択された出題形式を読み取る
      question_order = params[:question_order].to_i
			@questions = Question.selectQuestionByOrder(question_order, genre_ids, level_ids, question_count)
      @style_id =  params[:style_id].to_i
  end


	def initialize_session
    # まずはセッション変数を取得する
    # next_questionメソッドで使うため
    # session[:asked_question_ids] ||= [] でセッションが未定義なら新しく作るという意味になる
    session[:asked_question_ids] ||= []
    session[:selected_genre_ids] ||= []
    # 正答数を計上するためのセッションを取得する
    session[:correct_answers]||= []
    # 難易度を格納するためのセッション
    session[:selected_level_ids] ||= []
    # 出題数を格納するためのセッション
    session[:question_nums] ||= []
    # 間違えた問題を格納するためのセッション
    session[:incorrect_answers] ||= []
    # next_action用のセッション
    # session[:question_range]||= []

  end

  def adjustSession
    # いくつかのセッションをリセットする
    session[:asked_question_ids] = []
    # 出題数を格納するためのセッション
    session[:question_nums] = []
    # 不正解問題のidを取得する
    incorrect_question_ids = session[:incorrect_answers]
    session[:correct_answers] = []
    session[:incorrect_answers] = []
    if session[:question_range].present?
      session[:question_range] = []
    else
      session[:question_range]||= []
    end
    session[:question_range] << incorrect_question_ids
    return incorrect_question_ids
  end

  private

  def renderHTML
    if request.post?
      return
    else
      render html: '<script>alert("選択内容が解除されトップページに戻ります。");window.location.href = "/";</script>'.html_safe
    end
  end

  def count_asked_question
    return (session[:asked_question_ids].length - 1)
  end

  def count_correct_counts
    return session[:correct_answers].length
  end

end
