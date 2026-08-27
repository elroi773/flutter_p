import 'package:flutter/material.dart';

// Flutter 앱의 시작점입니다.
void main() {
  runApp(const MyApp());
}

// 앱 전체의 공통 설정을 담당하는 최상위 위젯입니다.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Study',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // 처음 보여줄 화면을 Todo 학습 페이지로 지정합니다.
      home: const TodoStudyPage(),
    );
  }
}

// 할 일 목록을 직접 추가, 완료, 삭제해볼 수 있는 학습용 페이지입니다.
class TodoStudyPage extends StatefulWidget {
  const TodoStudyPage({super.key});

  @override
  State<TodoStudyPage> createState() => _TodoStudyPageState();
}

class _TodoStudyPageState extends State<TodoStudyPage> {
  // TextField에 입력된 값을 읽고 비울 때 사용하는 컨트롤러입니다.
  final TextEditingController todoController = TextEditingController();

  // 화면에 표시할 할 일 데이터입니다.
  final List<TodoItem> todos = [
    TodoItem(title: 'TextField로 글자 입력받기'),
    TodoItem(title: 'setState로 화면 다시 그리기'),
    TodoItem(title: 'ListView로 목록 보여주기'),
  ];

  // 완료된 할 일 개수를 계산해 상단 상태 문구에 보여줍니다.
  int get completedCount {
    return todos.where((todo) => todo.isDone).length;
  }

  // 입력창의 텍스트를 새 할 일로 추가합니다.
  void addTodo() {
    final String text = todoController.text.trim();

    // 공백만 입력했을 때는 목록에 추가하지 않습니다.
    if (text.isEmpty) {
      return;
    }

    setState(() {
      todos.add(TodoItem(title: text));
      todoController.clear();
    });
  }

  // 체크박스를 누를 때마다 완료 상태를 반대로 바꿉니다.
  void toggleTodo(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
    });
  }

  // 삭제 버튼을 누른 항목을 목록에서 제거합니다.
  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  void dispose() {
    // 위젯이 사라질 때 컨트롤러도 정리해 메모리 누수를 막습니다.
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 기초 예제'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '오늘 할 일',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '완료: $completedCount / ${todos.length}',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      decoration: const InputDecoration(
                        labelText: '새 할 일',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => addTodo(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton.filled(
                    onPressed: addTodo,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                // 목록이 비어 있으면 안내 문구를, 항목이 있으면 스크롤 목록을 보여줍니다.
                child: todos.isEmpty
                    ? const EmptyTodoMessage()
                    : ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final TodoItem todo = todos[index];

                          return TodoTile(
                            todo: todo,
                            onChanged: () => toggleTodo(index),
                            onDelete: () => removeTodo(index),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 12),
              const StudyHint(),
            ],
          ),
        ),
      ),
    );
  }
}

// 할 일 하나의 데이터 구조입니다.
class TodoItem {
  TodoItem({required this.title, this.isDone = false});

  // 사용자가 입력한 할 일 내용입니다.
  final String title;

  // 체크박스 선택 여부, 즉 완료 상태입니다.
  bool isDone;
}

// 할 일 하나를 카드 형태로 보여주는 재사용 위젯입니다.
class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.onDelete,
  });

  final TodoItem todo;

  // 체크박스가 눌렸을 때 부모 위젯에 변경 요청을 전달합니다.
  final VoidCallback onChanged;

  // 삭제 버튼이 눌렸을 때 부모 위젯에 삭제 요청을 전달합니다.
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Checkbox(value: todo.isDone, onChanged: (_) => onChanged()),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
            color: todo.isDone ? Colors.black45 : Colors.black87,
          ),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
        ),
      ),
    );
  }
}

// 할 일이 하나도 없을 때 보여주는 빈 상태 안내 위젯입니다.
class EmptyTodoMessage extends StatelessWidget {
  const EmptyTodoMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '할 일이 없습니다.\n위 입력창에 새 할 일을 추가해보세요.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }
}

// 화면 아래에 학습 포인트를 간단히 보여주는 안내 박스입니다.
class StudyHint extends StatelessWidget {
  const StudyHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: const Text(
        '연습 포인트: TextField, List, Checkbox, 조건문, setState, dispose',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
