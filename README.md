# codepath
# Pre-work: tippy

**tippy** is a tip calculator application for iOS.

Submitted by: **Bright Soo**

Time spent: **24** hours spent in total

## User Stories

The following **required** functionality is complete:

* [Y] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [Y] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [Y] UI animations
* [N] Remembering the bill amount across app restarts (if <10mins)
* [Y] Using locale-specific currency and currency thousands separators.
* [Y] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented, all in **Settings** view:
 - **Slider controls** for each of the three tip percentage presets.
   - Automatically **ensures that percentage1 <= percentage2 <= percentage3**
     - Aside from [declaring variables for the individual slider controls and a variable representing the number of sliders](https://github.com/bsoo920/codepath/blob/436610feaf3d2dd2745f00ed45d390bb7ece45d3/tippy/SettingsViewController.swift#L162), **_the code can handle this mechanism on any number of sliders without further modification._**
 - Toggle tip calculation between **pre-tax** and **after-tax**.
    - When toggled to pre-tax, a tax rate input box appears (since tax rate is needed for pre-tax tip calculation).
    - When toggled to after-tax, the input box disappaars.
    - The appearance/disappearance of the input box is animated as sliding out/in and fading in/out.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/xlWcx8O.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

- App is designed for iPhone 5S.  It does not look good on other screen sizes.
- App icon is downloaded from internet.

## License

    Copyright 2017 Bright Soo

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
