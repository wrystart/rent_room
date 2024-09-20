import { IColor } from '../../models/HomeData';

@Component
export default struct Index {
  @StorageProp('topHeight') topHeight: number = 0;
  @BuilderParam navBuilderParam: ($$: IColor) => void = this.customBuilder
  @BuilderParam contentBuilderParam: () => void = this.customBuilder
  // 存储滚动条位置（y轴滚动距离）
  scrollY: number = 0;
  @State bgColor: string = 'rgba(0,0,0,0)'
  @State fontColor: string = 'rgba(255,255,255,1)'

  @Builder
  customBuilder() {
  }

  // 处理滚动事件
  handleScroll = (xOffset: number, yOffset: number) => {
    // 更新滚动距离
    this.scrollY += yOffset;
    // 计算颜色
    this.calcColor()
  }
  calcColor = () => {
    if (this.scrollY < 10) {
      // 到达顶部，渐变开始
      this.bgColor = 'rgba(255,255,255,0)';
      this.fontColor = 'rgb(255,255,255)';

    } else if (this.scrollY <= 100) {
      // 渐变中（透明度 0 -> 1）
      const colorOpacity = (this.scrollY - 10) / (100 - 10);
      this.bgColor = `rgba(255,255,255,${colorOpacity})`;
      this.fontColor = `rgba(0,0,0,${colorOpacity})`;

    } else {
      // 渐变全部完成
      this.bgColor = 'rgb(255,255,255)';
      this.fontColor = 'rgb(0,0,0)';
    }
  }

  build() {
    Stack() {
      Scroll() {

        Column() {
          this.contentBuilderParam()

        }
        .width('100%')

      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
      .onDidScroll(this.handleScroll)

      // 搜索区
      // 按引用传递，传递的参数可为状态变量，且状态变量的改变会引起\@Builder方法内的UI刷新
      Column() {
        this.navBuilderParam({fontColor: this.fontColor })
      }.backgroundColor(this.bgColor).padding({ top: this.topHeight })
    }.width('100%').alignContent(Alignment.TopStart)
  }
}