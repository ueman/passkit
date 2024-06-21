# passkit_ui

Package with widgets to visualize `PkPass` files with the help of [`passkit`](https://pub.dev/packages/passkit).

Design docs: 
- https://developer.apple.com/design/human-interface-guidelines/wallet
- https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1


## Image docs

Taken from [here](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1).

# Images Fill Their Allotted Space
The pass layout allots a certain area on the front of the pass for each image. Images are scaled (preserving aspect ratio) to fill this allotted space. Images with a different aspect ratio than their allotted space are cropped after being scaled. The space allotted is as follows:

- The background image (`background.png`) is displayed behind the entire front of the pass. The expected dimensions are 180 x 220 points. The image is cropped slightly on all sides and blurred. Depending on the image, you can often provide an image at a smaller size and let it be scaled up, because the blur effect hides details. This lets you reduce the file size without a noticeable difference in the pass.
- The footer image (`footer.png`) is displayed near the barcode. The allotted space is 286 x 15 points.
- The icon (`icon.png`) is displayed when a pass is shown on the lock screen and by apps such as Mail when showing a pass attached to an email. The icon should measure 29 x 29 points.
- The logo image (`logo.png`) is displayed in the top left corner of the pass, next to the logo text. The allotted space is 160 x 50 points; in most cases it should be narrower.
- The strip image (`strip.png`) is displayed behind the primary fields.
  - **On iPhone 6 and 6 Plus** The allotted space is 375 x 98 points for event tickets, 375 x 144 points for gift cards and coupons, and 375 x 123 in all other cases.
  - **On prior hardware** The allotted space is 320 x 84 points for event tickets, 320 x 110 points for other pass styles with a square barcode on devices with 3.5 inch screens, and 320 x 123 in all other cases.
- The thumbnail image (`thumbnail.png`) displayed next to the fields on the front of the pass. The allotted space is 90 x 90 points. The aspect ratio should be in the range of 2:3 to 3:2, otherwise the image is cropped.

> [!NOTE ]The dimensions given above are all in points. On a non-Retina display, each point equals exactly 1 pixel. On a Retina display, there are 2 or 3 pixels per point, depending on the device. To support all screen sizes and resolutions, provide the original, @2x, and @3x versions of your art.

