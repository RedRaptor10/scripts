// ==UserScript==
// @name         Auto-Scroll Twitter
// @namespace    http://tampermonkey.net/
// @version      2025-07-13
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
const tweetCSS = '[data-testid="cellInnerDiv"]';

var autoScroll = true;
var currentTweet = null;
var tweetCounter = 0;
var scrollInterval = null;

function checkAutoScroll() {
	// If previously manually scrolling timeline and then scrolled back to top, restart auto-scroll
	if (!autoScroll && isAtTopOfPage()) {
		autoScroll = true;
		setScrollInterval();
	}
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

	if (!reverseScroll) {
		currentTweet = currentTweet.nextElementSibling;
	} else {
		if (tweetCounter < maxTweets) {
			currentTweet = currentTweet.nextElementSibling;
		} else {
			currentTweet = currentTweet.previousElementSibling;
		}
	}
	if (!currentTweet) return;

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

function maxTweetsReached() {
	if (maxTweets <= 0) return false;

	// If max tweets reached, scroll back to top and reset tweetCounter
	if ((!reverseScroll && tweetCounter >= maxTweets) || (reverseScroll && tweetCounter >= maxTweets * 2)) {
		const selectedList = document.querySelector('a[href="/home"][aria-selected="true"]');
		selectedList.click();

		tweetCounter = 0;
		currentTweet = null;
		clearInterval(scrollInterval);
		scrollInterval = null;
		setScrollInterval();

		return true;
	}

	return false;
}

function setScrollInterval() {
	setTimeout(() => {
        // If manually scrolling timeline, stop auto-scroll
		if (autoScroll == true && !isAtTopOfPage()) {
			autoScroll = false;
			return;
		}

		if (scrollInterval == null) {
			scrollInterval = setInterval(scrollTimeline, scrollTime * 1000);
		}
	}, startupDelay * 1000);
}

setInterval(checkAutoScroll, 1000);
setScrollInterval();
