package com.reactlibrary.taboola;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

public class RNTaboolaModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNTaboolaModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNTaboola";
  }
}