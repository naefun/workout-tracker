import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_tab_state.g.dart';

enum TabItem { currentWorkout, previousWorkouts }

typedef CurrentTabStateData = ({
  TabItem currentTab,
});

const CurrentTabStateData initialCurrentTabStateData =
    (currentTab: TabItem.currentWorkout,);

@Riverpod(keepAlive: true)
class CurrentTabNotifier extends _$CurrentTabNotifier {
  @override
  CurrentTabStateData build() => initialCurrentTabStateData;

  void _setState({
    TabItem? currentTab,
  }) {
    state = (currentTab: currentTab ?? state.currentTab);
  }

  // Provide "true" for the values that should be reset
  void _resetState({
    bool currentTab = false,
  }) {
    state = (
      currentTab: currentTab == true
          ? initialCurrentTabStateData.currentTab
          : state.currentTab,
    );
  }

  void setCurrentTab(TabItem tab) {
    _setState(currentTab: tab);
  }

  void resetState() => state = initialCurrentTabStateData;
}
