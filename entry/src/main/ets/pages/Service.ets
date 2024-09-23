import ScrollContainer from '../components/ScrollContainer/Index'
import Bg from '../views/Service/Bg'
import NavBar from '../views/Service/NavBar'

@Component
export default struct Service {
  @Builder
  navBuilder() {
    NavBar()

  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
    }.width('100%')
  }

  build() {
    ScrollContainer({
      navBuilderParam: this.navBuilder,
      contentBuilderParam: () => {
        this.contentBuilder()
      }
    })
  }
}