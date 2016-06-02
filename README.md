# react-native-qbimagepicker

## Options

| Option | Description | Type  | Default  |
| ------ |-------------| -----:|---------:|
| animate | | boolean | true |
| allowsMultipleSelection |	multiple photos can be selected at once |	boolean |	false |
| maximumNumberOfSelection | max number of photos that can be selected at once | integer | 0 (unlimited) |
| minimumNumberOfSelection | min number of photos that can be selected at once | integer | 0 (unlimited) |
| assetCollectionSubtypes | list of albums to show before the user’s own albums. Options are cameraRoll, photoStream, panoramas, videos, and bursts. Specified albums are shown in the order they are listed, with the User’s albums following. | array | ['cameraRoll', 'photoStream', 'panoramas', 'videos','burst'] |
| mediaType	| limit the type of media to videos, images, or any. | string | 'any' |
| prompt | an optional message to display above the picker | | string |
| showsNumberOfSelectedAssets |	display a count of selected items onscreen | boolean | true |
| numberOfColumnsInPortrait | number of grid columns to show in portrait mode | integer | 4 |
| numberOfColumnsInLandscape | number of grid columns to show in landscape mode | integer | 7 |
