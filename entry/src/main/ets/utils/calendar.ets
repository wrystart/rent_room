export default function getCalendar() {
  const date = new Date()
  // 当前月份
  const currentMonth = date.getMonth() + 1
  return [
    calcLastMonth(currentMonth, 2),
    calcLastMonth(currentMonth, 1),
    currentMonth,
    calcNextMonth(currentMonth, 1),
    calcNextMonth(currentMonth, 2),
    calcNextMonth(currentMonth, 3)
  ].map(val => addZero(val))

}

// 计算之前的月份
function calcLastMonth(currentMonth: number, num: number) {
  // 假设当前是1月，1 - 1 = 0 希望得到 12 月
  const val = currentMonth - num;
  return val < 1 ? 12 + val : val;
}

// 计算之后的月份
function calcNextMonth(currentMonth: number, num: number) {
  // 假设当前是12月，12 + 1 = 13 希望得到 1 月
  const val = currentMonth + num;
  return val > 12 ? val - 12 : val;
}

// 补0
function addZero(val: number): string {
  return val < 10 ? '0' + val : val + '';
}