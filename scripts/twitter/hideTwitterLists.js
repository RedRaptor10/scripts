// ==UserScript==
// @name         Hide Twitter Lists
// @namespace    http://tampermonkey.net/
// @version      2026-10-10
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

function hideTwitterLists() {
	const twitterLists = document.querySelectorAll(twitterListsCSS);

	twitterLists.forEach(x => {
		const span = x.querySelector('span');
		if (!span) return;

		const listName = span.innerHTML.trim();

		if (twitterListsToHide.includes(listName)) {
			x.style.display = 'none';
		}
	});
}

function waitForTwitterLists() {
	return new Promise((resolve) => {
		const checkLists = () => {
			const twitterLists = document.querySelectorAll(twitterListsCSS);
			const loadedListNames = new Set();

			twitterLists.forEach(x => {
				const span = x.querySelector('span');
				if (span) {
					loadedListNames.add(span.innerHTML.trim());
				}
			});

			return twitterListsToHide.every(name =>
				loadedListNames.has(name)
			);
		};

		if (checkLists()) {
			return resolve();
		}

		const observer = new MutationObserver(() => {
			if (checkLists()) {
				observer.disconnect();
				resolve();
			}
		});

		observer.observe(document.body, {
			childList: true,
			subtree: true,
			characterData: true
		});
	});
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

async function initHideTwitterLists() {
	// Wait until all Twitter Lists to hide have loaded
	await waitForTwitterLists();

	// Hide Twitter Lists
	hideTwitterLists();

	// Click the first remaining list to load its timeline
	clickNextVisibleList();
}

initHideTwitterLists();
