part of"../home_view_bottom_sheet.dart";

class _TagsPlace extends StatelessWidget {
  const _TagsPlace();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalManageCubit, GlobalManageState>(
      builder: (context, state) {
        final blocBuilderContext = context;
        return Padding(
          padding: context.padding.topOnlyNormal,
          child: SizedBox(
            width: context.sized.width,
            height: context.sized.dynamicHeigth(0.17),
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: context.padding.allNormal,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: context.sized.normalValue,
                crossAxisSpacing: context.sized.normalValue,
                childAspectRatio: context.sized.dynamicHeigth(0.078) / context.sized.dynamicHeigth(0.25),
              ),
              itemCount: state.personalTags?.length ?? context.sized.kZero.toInt(),
              itemBuilder: (context, index) {
                return CategoryButton(
                  personalTags: state.personalTags,
                  categoryTitle: state.personalTags?.elementAt(index).tag,
                  index: index,
                  blocBuilderContext: blocBuilderContext,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

