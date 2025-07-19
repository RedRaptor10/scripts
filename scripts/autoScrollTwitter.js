// ==UserScript==
// @name         Auto-Scroll Twitter
// @namespace    http://tampermonkey.net/
// @version      2025-07-19
// @description  Automatically scroll Twitter timeline at a set interval. Scrolls through one tweet at a time, then scrolls back to top.
// @author       RedRaptor10
// @match        https://twitter.com/*
// @match        https://x.com/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

'use strict'

const scrollTime = 30; // Time before scrolling to next tweet (in seconds)
const startupDelay = 30; // Delay time before scrolling starts (in seconds, set to 0 to disable)
const maxTweets = 25; // Maximum tweets to scroll to before scrolling back to top (set to 0 to disable)
const reverseScroll = true; // Scroll in reverse-order after reaching maxTweets

const tablistCSS = 'nav.TimelineTabs';
const timelineCSS = 'main section[role="region"]';
const tweetCSS = '[data-testid="cellInnerDiv"]:not([style*="display: none;"])';

var autoScroll = true;
var currentTweet = null;
var tweetCounter = 0;
var scrollInterval = null;
var addedEvents = false;

function checkPage() {
	// Set Event Listeners
	addEvents();
}

function addEvents() {
	if (addedEvents || !document.querySelector(timelineCSS)) return;

	addClickEvents();

	// Disable Auto-Scroll if scrolling manually
	document.addEventListener('wheel', () => {
		disableAutoScroll();
	});

	document.addEventListener('mousedown', event => {
		// Middle Mouse Button
		if (event.button == 1) {
			disableAutoScroll();
		}
	});

	document.addEventListener('keydown', event => {
		// Up/Down Keys
		if (event.keyCode == 38 || event.keyCode == 40) {
			disableAutoScroll();
		}
	});

	addedEvents = true;
}

function addClickEvents() {
	var links = document.querySelectorAll('a[href="/home"]');
	links.forEach(x => {
		x.addEventListener('click', () => {
			resetAutoScroll();
		});
	});
}

function disableAutoScroll() {
	autoScroll = false;
	tweetCounter = 0;
	currentTweet = null;
	clearInterval(scrollInterval);
	scrollInterval = null;
}

function resetAutoScroll() {
	autoScroll = true;
	tweetCounter = 0;
	currentTweet = null;
	clearInterval(scrollInterval);
	scrollInterval = null;
	setScrollInterval();
}

function setScrollInterval() {
	setTimeout(() => {
		if (!autoScroll) return;

		if (scrollInterval == null) {
			scrollInterval = setInterval(scrollTimeline, scrollTime * 1000);
		}
	}, startupDelay * 1000);
}

function isAtTopOfPage() {
	const tablist = document.querySelector(tablistCSS);
	const timeline = document.querySelector(timelineCSS);

	if (!tablist || !timeline) return false;

	const tablistBottom = tablist.getBoundingClientRect().bottom;
	const timelineTop = timeline.getBoundingClientRect().top;

	return tablistBottom <= timelineTop + 1;
}

function scrollTimeline() {
	if (maxTweetsReached()) return;

	const tablist = document.querySelector(tablistCSS);
	if (!tablist) return;

	if (currentTweet == null) {
		currentTweet = document.querySelector(tweetCSS);
	}
	if (!currentTweet) return;

	// Get Next Tweet
	currentTweet = getNextTweet();
	if (!currentTweet) return;

	// Handle Hidden Tweets
	while (isHiddenTweet(currentTweet)) {
		currentTweet = getNextTweet();
		if (!currentTweet) return;
	}

	const offsetY = tablist.getBoundingClientRect().height;
	const scrollTop = currentTweet.getBoundingClientRect().top + window.scrollY - offsetY;

	window.scrollTo({
		behavior: 'smooth',
		top: scrollTop,
	});

	if (maxTweets > 0) {
		tweetCounter++;
	}
}

function getNextTweet() {
	let nextTweet;

	if (!reverseScroll) {
		nextTweet = currentTweet.nextElementSibling;
	} else {
		if (tweetCounter < maxTweets) {
			nextTweet = currentTweet.nextElementSibling;
		} else {
			nextTweet = currentTweet.previousElementSibling;
		}
	}

	return nextTweet;
}

function isHiddenTweet(element) {
	if (element.style.display == 'none' || element.style.visibility == 'hidden') {
		return true;
	}

	let childElement = element.querySelector('article');
	if (!element.contains(childElement)) {
		return true;
	}

	return false;
}

function maxTweetsReached() {
	if (maxTweets <= 0) return false;

	// If max tweets reached, scroll back to top and reset tweetCounter
	if ((!reverseScroll && tweetCounter >= maxTweets) || (reverseScroll && tweetCounter >= maxTweets * 2)) {
		const selectedList = document.querySelector('a[href="/home"][aria-selected="true"]');
		selectedList.click();

		resetAutoScroll();

		return true;
	}

	return false;
}

setInterval(checkPage, 1000);
setScrollInterval();
