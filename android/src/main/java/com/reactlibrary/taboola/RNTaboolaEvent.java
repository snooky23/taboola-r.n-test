package com.reactlibrary.taboola;

public enum RNTaboolaEvent {
    EVENT_ON_ORGANIC_ITEM_CLICK("onOrganicItemClick"),
    EVENT_ON_DID_LOAD_SUCCESS("onDidLoad"),
    EVENT_ON_DID_LOAD_FAIL("onDidFailToLoad"),
    EVENT_ON_AD_ITEM_CLICK("onAdItemClick");

    private final String mName;

    RNTaboolaEvent(final String name) {
        mName = name;
    }

    @Override
    public String toString() {
        return mName;
    }
}
