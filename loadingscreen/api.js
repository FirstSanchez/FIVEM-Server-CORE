var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player;
function onYouTubeIframeAPIReady() {
  player = new YT.Player('video', {
    videoId: 'ypLMzALvWM4',
    playerVars: { 'autoplay': 1, 'controls': 0, 'disablekb': 1, 'loop':1},
    events: {
      'onReady': onPlayerReady,
      'onStateChange': onPlayerStateChange
    }
  });
}

function onPlayerReady(event) {
  event.target.playVideo();
}

var done = false;
function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.PLAYING && !done) {
    done = true;
    player.setVolume(valPercent)
  } else if (event.data === YT.PlayerState.ENDED) {
    player.playVideo();
    player.setVolume(valPercent)
  }
}