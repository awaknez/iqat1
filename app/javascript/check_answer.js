function check_answer(){
    var images = document.querySelectorAll('.question_image');
    for (var i = 0; i < images.length; i++) {
      var image = images[i];
      var image_url = image.style.backgroundImage.slice(4, -1).replace(/['"]/g, "");
      var img = new Image();
      img.onload = function() {
        image.classList.add('loaded');
      };
      img.src = image_url;
    }  

  const buttons = document.querySelectorAll(".buttons");
   // 以下でビューファイルの問題idが入っているフォームを取得
  // const timeInput = document.getElementById("time_input");

  // 以下でビューファイルの問題idが入っているフォームの値を取得。これをパスに使う。
//   const questionId = timeInput.getAttribute("value");
//   console.log(questionId);

buttons.forEach(function(button){
    button.addEventListener("click",function(e){

      e.preventDefault();

      var token = document.getElementsByName('csrf-token')[0].content;
      var choice_id = this.getAttribute('data-choice-id');
      // 選択肢の名前（アやイなど）を取得
      var chosenName = this.getAttribute('data-choice-name');
      // 選択肢ボタンに問題番号を含めているのでそれを取得
      var question_id = this.getAttribute('data-question-id');

      // ボタンを押せば結果のエリアまでスクロールする
        // #result要素の位置を取得
        var resultElement = document.querySelector('#resultArea');
        var resultPosition = resultElement.getBoundingClientRect().top + window.pageYOffset;
  
        // スクロールする
        window.scrollTo({ top: resultPosition, behavior: 'smooth' });

      // 解答・解説部分の表示
      const commentaryArea = document.getElementById("commentaryArea");
      commentaryArea.removeAttribute("style");

      // 選択した解答（選択肢）をテキスト情報として要素に加える
      document.querySelector('#chosenName').textContent = "あなたの解答:" + chosenName;

      const xhr = new XMLHttpRequest();
      xhr.open('POST', '/questions/check', true);
      xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
      xhr.setRequestHeader('X-CSRF-Token', token); // トークンをリクエストヘッダーに追加
      xhr.onload = function() {
        if (xhr.status === 200) {
          // 正誤判定の結果を表示
          var data = JSON.parse(xhr.responseText);
          
          // var result = data.result ? '正解！' : '不正解...';
          // document.querySelector('#result').textContent = result;
          // 結果によって挿入するhtmlタグを分岐
          if (data.result) {
            document.querySelector('#result').innerHTML = '<p class=" text-center">正解<span class="text-success h4"><b> ◯</b></span></p>';
          } else {
            document.querySelector('#result').innerHTML = '<p class=" text-center">残念。不正解<span class="text-danger h4"><b> ×</b></span></p>';
          }
        }
        else {
          console.error(xhr.statusText);
        }
      };
      // xhr.onerror = function() {
      //   console.error(xhr.statusText);
      // };
      // XHR.responseType = "json";
      // xhr.send('choice_id=' + choice_id);

      // 選択肢番号と問題番号を送信
      xhr.send('choice_id=' + encodeURIComponent(choice_id) + '&question_id=' + encodeURIComponent(question_id));
      
//     })

      // 選択肢ボタンもしくは「解答を見る」ボタンを押すと、ボタンを非表示へ。解答を見てから解答することを防ぐ
      const buttonList = document.getElementById("button-list");
      buttonList.setAttribute("style","display:none;");
      const seeAnsButton = document.getElementById("seeAnsButton");
      seeAnsButton.setAttribute("style","display:none;");
    });
  });
};


window.addEventListener('load',check_answer);