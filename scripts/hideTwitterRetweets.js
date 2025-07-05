// ==UserScript==
// @name         Hide Twitter Retweets
// @namespace    http://tampermonkey.net/
// @version      2025-07-04
// @description  Hide Retweets from Twitter
// @author       RedRaptor10
// @match        https://twitter.com/*
// @match        https://x.com/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

'use strict'

// Add lists to hide retweets from (ie. 'MyList1', 'MyList2', etc.). Leave empty to hide retweets from all lists.
const twitterLists = [];

const selectedListCSS = 'a[href="/home"][aria-selected="true"] span';
const tweetCSS = '[data-testid="cellInnerDiv"]';
const retweetCSS = '[data-testid="socialContext"]';
const retweetSelector = tweetCSS + ':has(' + retweetCSS + '):not([style*="display: none;"])';

function hideRetweets() {
	const selectedList = document.querySelector(selectedListCSS);
	if (!selectedList) return;

	const selectedListName = selectedList.innerHTML;
	if (twitterLists.length > 0 && !twitterLists.includes(selectedListName)) return;

	const retweets = document.querySelectorAll(retweetSelector);

	retweets.forEach(x => {
		x.style.display = 'none';
	});
}

const retweetObserver = new MutationObserver(mutations => {
	for (const mutation of mutations) {
		if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
			mutation.addedNodes.forEach(node => {
				if (node.nodeType === 1 && node.matches(retweetSelector)) {
					hideRetweets();
				}
			});
		}
	}
});

retweetObserver.observe(document.body, { childList: true, subtree: true });
