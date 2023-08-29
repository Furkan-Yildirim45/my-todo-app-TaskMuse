
part of'../main_page_view.dart';

class _PageTopComponent extends StatelessWidget with _PageOfTopComponentUtility{
  _PageTopComponent();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: reminderBubbleHeight(context) * 2,
      width: context.sized.width,
      decoration: BoxDecoration(
          color: AppColor.aquaticCool.getColor(),
          image: DecorationImage(
              image: AssetImage(topPlaceBackgroundImageUrl),
              fit: BoxFit.cover)),
      child: Padding(
        padding: context.padding.allMedium,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _userNameTextAndProfileUrlPlace(context),
              //bottom of top place
              _reminderPlaCE(context)
            ]),
      ),
    );
  }

  Container _reminderPlaCE(BuildContext context) {
    return Container(
              width: context.sized.width,
              height: reminderBubbleHeight(context),
              decoration: BoxDecoration(
                  color: AppColor.dragonFly.getColor(),
                  borderRadius: context.border.smallBorderRadius
              ),
              child: Stack(
                  children: [
                    Padding(
                      padding: customReminderPadding(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reminderTodayText,style: context.general.textTheme.titleLarge?.copyWith(color: Colors.white),),
                              TitleSmallTextWithSpace(text: titleOfMostCloseTask,top: context.sized.smallValue,),
                              TitleSmallTextWithSpace(text: dateOfMostCloseTask,top: context.sized.smallValue,),
                            ],
                          ),
                          ImageContainer(
                            image: reminderImageUrl,
                            height: context.sized.largeValue,
                            width: context.sized.largeValue,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: context.sized.kZero,
                      top: context.sized.kZero,
                      child: InkWell(
                        borderRadius: context.border.largeBorderRadius,
                        onTap: (){},
                        child: Container(
                          width: context.sized.littleLargeValue,
                          height: context.sized.littleLargeValue,
                          decoration: BoxDecoration(
                              borderRadius: context.border.largeBorderRadius
                          ),
                          child: Icon(Icons.close,size: context.iconSize.small,color: Colors.white,),
                        ),
                      ),
                    ),
                  ]),
            );
  }

  Row _userNameTextAndProfileUrlPlace(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style: context
                          .general.textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                     TitleSmallTextWithSpace(text: tasksOfToday,)
                  ],
                ),
                ImageContainer(image: personImage,)
              ],
            );
  }
}

mixin _PageOfTopComponentUtility{
  final String topPlaceBackgroundImageUrl = "assets/images/buble.png";
  EdgeInsets customReminderPadding(BuildContext context) => EdgeInsets.only(left: context.sized.mediumValue,right: context.sized.littleLargeValue);
  final String reminderTodayText = "Today Reminder";
  final String titleOfMostCloseTask = "Meeting with client";
  final String dateOfMostCloseTask = "10.00 AM";
  final String reminderImageUrl = "assets/images/notification.png";
  final String customerName = "Hello Olivia!";
  final String tasksOfToday = "Today you have 9 tasks";
  final String personImage = "assets/images/person_girl.png";
  double reminderBubbleHeight(BuildContext context) => context.sized.dynamicHeigth(0.15);
}