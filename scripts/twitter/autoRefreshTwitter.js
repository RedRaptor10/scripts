// ==UserScript==
// @name         Auto-Refresh Twitter
// @namespace    http://tampermonkey.net/
// @version      2026-01-02
// @description  Automatically refresh Twitter timeline at a set interval.
// @author       RedRaptor10
// @match        https://twitter.com/*
// @match        https://x.com/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

'use strict'

const refreshTime = 30; // Refresh timeline interval (in seconds)

const timelineCSS = '[role="tablist"] [role="tab"][aria-selected="true"]';

function isAtTopOfPage() {
	const tablist = document.querySelector('[role="tab"]');
	const timeline = document.querySelector('main section[role="region"]');

	if (!tablist || !timeline) return false;

	const tablistBottom = tablist.getBoundingClientRect().bottom;
	const timelineTop = timeline.getBoundingClientRect().top;

	return tablistBottom <= timelineTop + 1;
}

function refreshTimeline() {
	const timelineTabs = document.querySelector('nav.TimelineTabs');
	if (!timelineTabs) return;

	const selectedList = document.querySelector(timelineCSS);

	if (!selectedList) {
		console.error('Error refreshing timeline.');
		return;
	}

	if (!isAtTopOfPage()) return;

	selectedList.click();
}

setInterval(refreshTimeline, refreshTime * 1000);

