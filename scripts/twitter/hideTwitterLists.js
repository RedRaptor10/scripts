// ==UserScript==
// @name         Hide Twitter Lists
// @namespace    http://tampermonkey.net/
// @version      2026-10-13
// @description  Hide Lists from Twitter
// @author       RedRaptor10
// @match        https://twitter.com/*
// @match        https://x.com/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

'use strict'

// Add lists to hide (ie. 'Following', 'MyList1', 'MyList2', etc.)
const twitterListsToHide = ['Following'];

const twitterListsCSS = '[role="tablist"] [role="presentation"]';

let hasClickedNextList = false;
let isProcessing = false;

function getLoadedListNames() {
	const names = new Set();

	document.querySelectorAll(twitterListsCSS).forEach(x => {
		const span = x.querySelector('span');
		if (span) {
			names.add(span.innerHTML.trim());
		}
	});

	return names;
}

function allTargetListsLoaded() {
	const loadedListNames = getLoadedListNames();

	return twitterListsToHide.every(name =>
		loadedListNames.has(name)
	);
}

function hideTwitterLists() {
	let foundTargetList = false;

	document.querySelectorAll(twitterListsCSS).forEach(x => {
		const span = x.querySelector('span');
		if (!span) return;

		const listName = span.innerHTML.trim();

		if (twitterListsToHide.includes(listName)) {
			foundTargetList = true;
			x.style.display = 'none';
		}
	});

	return foundTargetList;
}

function clickNextVisibleList() {
	const twitterLists = document.querySelectorAll(twitterListsCSS);

	for (const x of twitterLists) {
		const span = x.querySelector('span');
		if (!span) continue;

		const listName = span.innerHTML.trim();

		// Skip lists that should be hidden
		if (twitterListsToHide.includes(listName)) continue;

		// Skip 'For you' list
		if (listName == 'For you') continue;

		// Click the first list that isn't hidden
		const tab = x.querySelector('[role="tab"]');
		tab.click();
		return;
	}
}

function processTwitterLists() {
	if (isProcessing) return;
	isProcessing = true;

	try {
		// Only proceed when at least one target list is present
		const foundTargetList = hideTwitterLists();

		if (!foundTargetList) {
			hasClickedNextList = false;
			return;
		}

		// Wait until every target list has loaded before clicking
		if (!allTargetListsLoaded()) return;

		// Hide the target lists and click the next visible list only once
		if (!hasClickedNextList) {
			hideTwitterLists();
			clickNextVisibleList();
			hasClickedNextList = true;
		}
	} finally {
		isProcessing = false;
	}
}

const observer = new MutationObserver(() => {
	processTwitterLists();
});

observer.observe(document.body, {
	childList: true,
	subtree: true,
	characterData: true
});

// Handle tabs that are already present
processTwitterLists();
