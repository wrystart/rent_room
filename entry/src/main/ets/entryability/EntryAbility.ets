import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { JSON } from '@kit.ArkTS';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });

    // 1.设置全屏
    // 应用窗口对象
    const windowClass = await windowStage.getMainWindow()
    // 设置全屏
    windowClass.setWindowLayoutFullScreen(true)
    // 获取状态栏高度
    const avoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
    // 注意：单位是px
    const topHeight = avoidArea.topRect.height;
    const bottomHeight = avoidArea.bottomRect.height;

    // 将状态栏高度存储起来
    AppStorage.setOrCreate('topHeight', px2vp(topHeight))
    AppStorage.setOrCreate('bottomHeight', px2vp(bottomHeight))
    // 设置状态栏的颜色
    windowClass.setWindowSystemBarProperties({
      statusBarContentColor: '#ffffff' // 状态栏内容颜色
    })
    // 获取屏幕宽度
    const props = windowClass.getWindowProperties()
    const windowWidth = props.windowRect.width; // 注意：单位是px
    const windowHeight = props.windowRect.height; // 注意：单位是px
    // 将屏幕宽度存储起来
    AppStorage.setOrCreate('windowWidth', px2vp(windowWidth))
    AppStorage.setOrCreate('windowHeight', px2vp(windowHeight))
    hilog.info(0x0000, 'cnm', JSON.stringify(props));
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
