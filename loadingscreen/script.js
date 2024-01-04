var header = document.getElementById("top-buttons");
var btns = header.getElementsByClassName("top-button");
var rightArrow = document.getElementById("right-arrow");
var leftArrow = document.getElementById("left-arrow");
const mySlider = document.getElementById("my-slider");
var overlay = true
var volume = 40

var currentPage = 0;
function load() {
  setTimeout(() => {
    Config.Team.forEach((team, index) => {
      $(".team-scroll-content").append(`<div class="team-box"><span style="color:${team.color}"id="team-name">${team.name}</span> <br> <span style="font-size:1.6vh;color:#929292;"id="team-role">${team.description}</span>
    <div class="team-box-image" style="background-image:url('${team.image}')"></div>
    <svg class="corner-image" style="left:20.8vh;top:-0.8vh;transform:scaleX(-1)"  width="4vh" height="4vh" viewBox="0 0 15 15" xmlns="http://www.w3.org/2000/svg">
        <path
          d="M9.87737 3H9.9H11.5C11.7761 3 12 3.22386 12 3.5C12 3.77614 11.7761 4 11.5 4H9.9C8.77164 4 7.95545 4.00039 7.31352 4.05284C6.67744 4.10481 6.25662 4.20539 5.91103 4.38148C5.25247 4.71703 4.71703 5.25247 4.38148 5.91103C4.20539 6.25662 4.10481 6.67744 4.05284 7.31352C4.00039 7.95545 4 8.77164 4 9.9V11.5C4 11.7761 3.77614 12 3.5 12C3.22386 12 3 11.7761 3 11.5V9.9V9.87737C3 8.77641 3 7.91948 3.05616 7.23209C3.11318 6.53416 3.23058 5.9671 3.49047 5.45704C3.9219 4.61031 4.61031 3.9219 5.45704 3.49047C5.9671 3.23058 6.53416 3.11318 7.23209 3.05616C7.91948 3 8.77641 3 9.87737 3Z"
        />
      </svg>
    <svg class="corner-image" style="left:-0.8vh;top:-0.8vh;transform:scaleX(1)"  width="4vh" height="4vh" viewBox="0 0 15 15" xmlns="http://www.w3.org/2000/svg">
        <path
          d="M9.87737 3H9.9H11.5C11.7761 3 12 3.22386 12 3.5C12 3.77614 11.7761 4 11.5 4H9.9C8.77164 4 7.95545 4.00039 7.31352 4.05284C6.67744 4.10481 6.25662 4.20539 5.91103 4.38148C5.25247 4.71703 4.71703 5.25247 4.38148 5.91103C4.20539 6.25662 4.10481 6.67744 4.05284 7.31352C4.00039 7.95545 4 8.77164 4 9.9V11.5C4 11.7761 3.77614 12 3.5 12C3.22386 12 3 11.7761 3 11.5V9.9V9.87737C3 8.77641 3 7.91948 3.05616 7.23209C3.11318 6.53416 3.23058 5.9671 3.49047 5.45704C3.9219 4.61031 4.61031 3.9219 5.45704 3.49047C5.9671 3.23058 6.53416 3.11318 7.23209 3.05616C7.91948 3 8.77641 3 9.87737 3Z"
        />
      </svg>
    <svg class="corner-image" style="left:-0.8vh;top:26.84vh;transform:scaleY(-1)"  width="4vh" height="4vh" viewBox="0 0 15 15" xmlns="http://www.w3.org/2000/svg">
        <path
          d="M9.87737 3H9.9H11.5C11.7761 3 12 3.22386 12 3.5C12 3.77614 11.7761 4 11.5 4H9.9C8.77164 4 7.95545 4.00039 7.31352 4.05284C6.67744 4.10481 6.25662 4.20539 5.91103 4.38148C5.25247 4.71703 4.71703 5.25247 4.38148 5.91103C4.20539 6.25662 4.10481 6.67744 4.05284 7.31352C4.00039 7.95545 4 8.77164 4 9.9V11.5C4 11.7761 3.77614 12 3.5 12C3.22386 12 3 11.7761 3 11.5V9.9V9.87737C3 8.77641 3 7.91948 3.05616 7.23209C3.11318 6.53416 3.23058 5.9671 3.49047 5.45704C3.9219 4.61031 4.61031 3.9219 5.45704 3.49047C5.9671 3.23058 6.53416 3.11318 7.23209 3.05616C7.91948 3 8.77641 3 9.87737 3Z"
        />
      </svg>
      <svg class="corner-image" style="left:20.74vh;top:26.84vh;transform:scale(-1)"  width="4vh" height="4vh" viewBox="0 0 15 15" xmlns="http://www.w3.org/2000/svg">
        <path
          d="M9.87737 3H9.9H11.5C11.7761 3 12 3.22386 12 3.5C12 3.77614 11.7761 4 11.5 4H9.9C8.77164 4 7.95545 4.00039 7.31352 4.05284C6.67744 4.10481 6.25662 4.20539 5.91103 4.38148C5.25247 4.71703 4.71703 5.25247 4.38148 5.91103C4.20539 6.25662 4.10481 6.67744 4.05284 7.31352C4.00039 7.95545 4 8.77164 4 9.9V11.5C4 11.7761 3.77614 12 3.5 12C3.22386 12 3 11.7761 3 11.5V9.9V9.87737C3 8.77641 3 7.91948 3.05616 7.23209C3.11318 6.53416 3.23058 5.9671 3.49047 5.45704C3.9219 4.61031 4.61031 3.9219 5.45704 3.49047C5.9671 3.23058 6.53416 3.11318 7.23209 3.05616C7.91948 3 8.77641 3 9.87737 3Z"
        />
      </svg>
  </div>`);
      if (Config.Team.length < 7) {
        $("#left-arrow").hide();
        $("#right-arrow").hide();
      }
    })
    $("#gallery-list").append(`
    <section>
    <article>
        <div class="grid-image" style="background-image:url(${Config.Gallery[0].image})"></div>
        <div class="grid-image" style="background-image:url(${Config.Gallery[1].image})"></div>
        <div class="grid-image" style="background-image:url(${Config.Gallery[2].image})"></div>
        <div class="grid-image" style="background-image:url(${Config.Gallery[3].image})"></div>
        <div class="grid-image" style="background-image:url(${Config.Gallery[4].image})"></div>
        <div class="grid-image" style="background-image:url(${Config.Gallery[5].image})"></div>
        <div class="grid-image" style="background-image:url(${Config.Gallery[6].image})"></div>
    </article>
</section>
    `);

    $("#stats-center-title").text(Config.Translations.title);
    $("#stats-center-description").text(Config.Translations.description);
    $(".stats-center-back").text(Config.Translations.backTitle);
    $("#team-button").text(Config.Translations.teamButton);
    $("#main-button").text(Config.Translations.mainButton);
    $("#gallery-button").text(Config.Translations.galleryButton);
    $("#loading-text").text(Config.Translations.loadingAssets);
    $("#team-container-title").text(Config.Translations.teamPageTitle);
    $("#stats-right-title").text(Config.Translations.rightStatsTitle);
    $("#discord").attr("src", Config.SocialMedia[0].image);
    $("#instagram").attr("src", Config.SocialMedia[1].image);
    $("#youtube").attr("src", Config.SocialMedia[2].image);
  }, 100);
}
load()

function next() {
  if (currentPage < Config.Team.length - 6) {
    currentPage++
    leftArrow.classList.remove("disabled")
    $(".team-box").css("left", `calc(-${currentPage * 25.02}vh - ${(currentPage + 1) * 0.8}vh)`)
    if (currentPage == Config.Team.length - 6) {
      rightArrow.classList.add("disabled")
    }
  }
}

function previous() {
  if (currentPage > 0) {
    currentPage--
    rightArrow.classList.remove("disabled")
    $(".team-box").css("left", `calc(-${currentPage * 25.02}vh - ${(currentPage + 1) * 0.8}vh)`)
  } if (currentPage == 0) {
    leftArrow.classList.add("disabled")
  }
}

for (var i = 0; i < btns.length; i++) {
  btns[i].addEventListener("click", function () {
    var current = document.getElementsByClassName("active");
    if (current.length > 0) {
      current[0].className = current[0].className.replace(" active", "");
    }
    this.className += " active";
  });
}

function progress(progress) {
  $("#loading-percent").text(progress + "%");
}

function copyToClipboard(id) {
  const body = document.querySelector('body');
  const area = document.createElement('textarea');
  var number = Math.floor((Math.random() * 1000) + 1);
  body.appendChild(area);
  area.value = Config.SocialMedia[id].link
  area.select();
  document.execCommand('copy');
  $("#copied").append(`<div class="copied id-${number}">${Config.Translations.copiedText}</div>`);

  setTimeout(function () {
    $(`.id-${number}`).fadeOut("slow", function () {
      $(`.id-${number}`).remove()
    })
  }, 1000)
}
window.addEventListener('message', function (e) {
  if (e.data.eventName === 'loadProgress') {
    progress(parseInt(e.data.loadFraction * 100));
  }
});

document.addEventListener("keyup", (event) => {
  if (event.keyCode == Config.HideOverlay) {
    if (overlay) {
      $('#overlay').hide();
      $('#status-text').text(Config.Translations.showOverlay);
      overlay = false
    } else {
      $('#overlay').show();
      $('#status-text').text(Config.Translations.hideOverlay);
      overlay = true
    }
  }
  return;
});

function getDate() {
  var now = new Date();
  var year = now.getFullYear();
  var month = now.getMonth() + 1;
  var day = now.getDate();
  if (month.toString().length == 1) {
    month = '0' + month;
  }
  if (day.toString().length == 1) {
    day = '0' + day;
  }
  var dateTime = day + '.' + month + '.' + year
  return dateTime;
}

setInterval(function () {
  currentDate = getDate();
  $('#stats-right-date').text(currentDate);

}, 1000);

function slider() {
  valPercent = (mySlider.value / mySlider.max) * 100;
  mySlider.style.background = `linear-gradient(to right, #fd0000 ${valPercent}%, #929292 ${valPercent}%)`;
  player.setVolume(valPercent)
  sliderValue.textContent = mySlider.value;
}
slider();

function teamPage() {
  $('.team-page').show();
  $('.main-page').hide();
  $('.gallery-page').hide();
}

function mainPage() {
  $('.team-page').hide();
  $('.main-page').show();
  $('.gallery-page').hide();
}

function galleryPage() {
  $('.team-page').hide();
  $('.main-page').hide();
  $('.gallery-page').show();
}