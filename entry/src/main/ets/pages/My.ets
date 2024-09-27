import ScrollContainer from '../components/ScrollContainer/Index'
import Bg from '../views/My/Bg'

@Component
export default struct My {
  @Builder
  navBuilder() {
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
    }.width('100%')
  }

  build() {
    ScrollContainer({
      contentBuilderParam: () => {
        this.contentBuilder()
      },
      navBuilderParam: this.navBuilder,
    })
  }
}