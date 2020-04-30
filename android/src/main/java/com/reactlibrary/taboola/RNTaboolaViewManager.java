


package com.reactlibrary.taboola;

//import android.support.annotation.Nullable;
import javax.annotation.Nullable;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.taboola.android.TaboolaWidget;
import com.taboola.android.api.TaboolaOnClickListener;
import com.taboola.android.js.OnRenderListener;
import com.taboola.android.js.TaboolaJs;
import com.taboola.android.listeners.TaboolaEventListener;

import java.util.ArrayList;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import java.util.HashMap;
import java.util.List;

import android.webkit.WebView;


public class RNTaboolaViewManager extends SimpleViewManager<RNTaboolaView> implements TaboolaEventListener, OnRenderListener {

    private static final String TAG = RNTaboolaViewManager.class.getSimpleName();
    private static final String REACT_CLASS = "RNTaboolaView";
    private static final String RN_VERSION = "RN_1.2.6.A";

    private static final String PROP_MODE = "mode";
    private static final String PROP_PUBLISHER = "publisher";
    private static final String PROP_PAGE_TYPE = "pageType";
    private static final String PROP_PAGE_URL = "pageUrl";
    private static final String PROP_PLACEMENT = "placement";
    private static final String PROP_TARGET_TYPE = "targetType";
    private static final String PROP_SCROLL_ENABED = "scrollEnabled";
    private static final String PROP_INTS_ENABED = "interceptScroll";
    private static final String PROP_VIEW_ID = "viewID";

    private RNTaboolaView lastInitedRnTaboolaView; // used only for click handling

    private List<RNTaboolaView> taboolaViewList = new ArrayList<>();

    private RCTEventEmitter eventEmitter; //Talks to JS callback functions.

    @Override
    public RNTaboolaView createViewInstance(final ThemedReactContext context) {

        eventEmitter = context.getJSModule(RCTEventEmitter.class);
        final RNTaboolaView taboolaView = new RNTaboolaView(context);

        lastInitedRnTaboolaView = taboolaView;

        taboolaViewList.add(taboolaView);

        taboolaView.setTaboolaEventListener(this);

        TaboolaJs.getInstance().setOnRenderListener(taboolaView,  onRenderListener);

        //add version
        taboolaView.setMediatedVia(RN_VERSION);

        taboolaView.setTaboolaEventListener(taboolaEventListener);

        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                context.runOnUiQueueThread(new Runnable() {
                    @Override
                    public void run() {
                        taboolaView.fetchContent();
                    }
                });
            }
        }, 1000);
        return taboolaView;
    }

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    @Nullable
    public Map getExportedCustomDirectEventTypeConstants() {
        MapBuilder.Builder builder = MapBuilder.builder();
        for (RNTaboolaEvent event : RNTaboolaEvent.values()) {
            builder.put(event.toString(), MapBuilder.of("registrationName", event.toString()));
        }
        return builder.build();
    }

    @ReactProp(name = PROP_MODE)
    public void setMode(RNTaboolaView view, String mode) {
        view.setMode(mode);
    }

    @ReactProp(name = PROP_PUBLISHER)
    public void setPublisher(RNTaboolaView view, String publisher) {
        view.setPublisher(publisher);
    }

    @ReactProp(name = PROP_PAGE_TYPE)
    public void setPageType(RNTaboolaView view, String pageType) {
        view.setPageType(pageType);
    }

    @ReactProp(name = PROP_PAGE_URL)
    public void setPageUrl(RNTaboolaView view, String pageUrl) {
        view.setPageUrl(pageUrl);
    }

    @ReactProp(name = PROP_PLACEMENT)
    public void setPlacement(RNTaboolaView view, String placement) {
        view.setPlacement(placement);
    }

    @ReactProp(name = PROP_TARGET_TYPE)
    public void setTargetType(RNTaboolaView view, String targeType) {
        view.setTargetType(targeType);
    }

    @ReactProp(name = PROP_SCROLL_ENABED)
    public void setScrollEnabled(RNTaboolaView view, boolean scrollEnabled) {
        view.setScrollEnabled(scrollEnabled);
    }

    @ReactProp(name = PROP_INTS_ENABED)
     public void setInterceptScroll(RNTaboolaView view, boolean interceptScroll) {
        view.setInterceptScroll(interceptScroll);
    }

    @ReactProp(name = PROP_VIEW_ID)
    public void setViewID(RNTaboolaView view, String viewID) {
        view.setViewId(viewID);
    }



    OnRenderListener onRenderListener = new  OnRenderListener() {
        @Override
        public void onRenderSuccessful(WebView webView, String placementName, int height) {
            String convertHeight = String.valueOf(height);
            WritableMap eventData = Arguments.createMap();
            eventData.putString("placementName", placementName);
            eventData.putString("height", convertHeight);

            eventEmitter.receiveEvent(webView.getId(), RNTaboolaEvent.EVENT_ON_DID_LOAD_SUCCESS.toString(), eventData);

        }

        @Override
        public void onRenderFailed(WebView webView, String placementName, String errorMessage) {
            WritableMap eventData = Arguments.createMap();
            eventData.putString("placementName", placementName);
            eventData.putString("error", errorMessage);
            eventEmitter.receiveEvent(webView.getId(), RNTaboolaEvent.EVENT_ON_DID_LOAD_FAIL.toString(), eventData);

        }
    };



//    //Example implementation: In the same Activity/Fragment as TaboolaWidget instance:
    TaboolaEventListener taboolaEventListener = new TaboolaEventListener() {
        @Override
        public boolean taboolaViewItemClickHandler(String url, boolean isOrganic) {
            //Code...
            WritableMap eventData = Arguments.createMap();
            eventData.putString("clickUrl", url);
//            eventData.putString("placementName", placementName);
//            eventData.putString("itemId", itemId);
            if (isOrganic) {
                Log.d(TAG, "onClick IF  isOrganic: " + isOrganic);
                eventEmitter.receiveEvent(lastInitedRnTaboolaView.getId(), RNTaboolaEvent.EVENT_ON_ORGANIC_ITEM_CLICK.toString(), eventData);

            }
            else {
                Log.d(TAG, "onClick IF  isOrganic: " + isOrganic);

                eventEmitter.receiveEvent(lastInitedRnTaboolaView.getId(), RNTaboolaEvent.EVENT_ON_AD_ITEM_CLICK.toString(), eventData);

            }
            return isOrganic;
        }

        @Override
        public void taboolaViewResizeHandler(TaboolaWidget taboolaWidget, int height) {
            //Code...
        }};

    @Override
    public boolean taboolaViewItemClickHandler(String clickUrl, boolean isOrganic) {
        return isOrganic;

    };

    @Override
    public void taboolaViewResizeHandler(TaboolaWidget taboolaWidget, int i) {
       // Log.i(TAG, "Taboola Resized to: " + i);
    }

    @Override
    public void onRenderSuccessful(WebView webView, String placementName, int height) {
       // Log.d(TAG, "onRenderSuccessful() called with: placementName = [" + placementName + "], height = [" + height + "]");
    }

    @Override
    public void onRenderFailed(WebView webView, String placementName, String errorMessage) {
       // Log.d(TAG, "onRenderFailed() called with: placementName = [" + placementName + "], errorMessage = [" + errorMessage + "]");
    }
}
