// ==UserScript==
// @name         Auto-Refresh Twitter
// @namespace    http://tampermonkey.net/
// @version      2025-07-13
// @description  Automatically refresh Twitter timeline at a set interval.
// @author       RedRaptor10
// @match        https://twitter.com/*
// @match        https://x.com/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

'use strict'

const refreshTime = 30; // Refresh timeline interval (in seconds)

function isAtTopOfPage() {
    const tablist = document.querySelector('[role="tab"]');
    const timeline = document.querySelector('main section[role="region"]');

    if (!tablist || !timeline) return false;

    const tablistBottom = tablist.getBoundingClientRect().bottom;
    const timelineTop = timeline.getBoundingClientRect().top;

    return tablistBottom <= timelineTop + 1;
}

function refreshTimeline() {
	const selectedList = document.querySelector('a[href="/home"][aria-selected="true"]');
	if (!selectedList) return;

    if (!isAtTopOfPage()) return;

	selectedList.click();
}

setInterval(refreshTimeline, refreshTime * 1000);