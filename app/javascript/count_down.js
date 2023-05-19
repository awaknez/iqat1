function countDown(){

// カウントダウンを表示する日付を設定する
    var countDownDate = new Date("Jan 13, 2024 00:00:00").getTime();

    // 現在の日付を取得する
    var now = new Date().getTime();

    // カウントダウンまでの時間を計算する
    var distance = countDownDate - now;

    // 日数を計算する
    var days = Math.floor(distance / (1000 * 60 * 60 * 24));

    // カウントダウンを表示する
    document.getElementById("countdownforRight").innerHTML =  days ;
    document.getElementById("countdown").innerHTML =  days ;

}

window.addEventListener('load',countDown);