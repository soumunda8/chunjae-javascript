var html = "";
var btn1 = document.getElementById("btn1");
var btn2 = document.getElementById("btn2");
var btn3 = document.getElementById("btn3");
var btn4 = document.getElementById("btn4");
var btn5 = document.getElementById("btn5");
var btn6 = document.getElementById("btn6");
var btn7 = document.getElementById("btn7");
var btn8 = document.getElementById("btn8");

var res1 = document.getElementById("res1");
var res2 = document.getElementById("res2");

btn1.addEventListener("click", function() {     // function 이름 없는 거 -> 익명의 함수
    objectInfo1();
});

function objectInfo1() {

    html += "------------------------------ LOCATION ------------------------------";

    for(var key in location) {
        //console.log("[ " + key + " ] " + location[key]);
        html += "<p>[ " + key + " ] " + location[key] + "</p>";
        // function O -> 메소드
        // function X -> 속성
    }

    html += "------------------------------ HISTORY ------------------------------";
    
    for(var key in history) {       // 방문했던 기록
        html += "<p>[ " + key + " ] " + history[key] + "</p>";
    }

    res1.innerHTML = html;
}

btn2.addEventListener("click", function() { // 뒤로가기 있는 속성
    // innerHtml -> setter : 왼쪽
    // location.href -> getter : 오른쪽
    res2.innerHTML = "<p>" + location.href + "</p>";
    setTimeout(function() {
        location.href = "https://www.naver.com/";
    }, 2500);
});

btn3.addEventListener("click", function() {
    location.reload();
});

btn4.addEventListener("click", function() { // 뒤로가기 없는 메소드
    location.replace("https://www.google.com/");
});

btn5.addEventListener("click", function() { // 뒤로가기 있는 메소드
    location.assign("https://www.daum.net");
});

btn6.addEventListener("click", function() { // 뒤로 가기
    history.back();
});

btn7.addEventListener("click", function() { // 앞으로 가기
    history.forward();
});

btn7.addEventListener("click", function() { // 원하는 대로 가기
    //history.go(1);      // 한 단계 앞으로
    //history.go(2);      // 두 단계 앞으로
    //history.go(-1);      // 한 단계 뒤로
    //history.go(-2);      // 두 단계 뒤로
    history.go(-1);
});

function moving() {
    var loc = document.getElementById("sel");
    if(loc.value != "") {
        //location.href = loc.value;
        //location.replace(loc.value);
        location.assign(loc.value);
    }
}