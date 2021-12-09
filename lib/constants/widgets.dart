import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String content;
  final GestureTapCallback onTap;
  const TaskCard(
      {Key? key,
      required this.title,
      required this.content,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (title.isNotEmpty && content.isNotEmpty)
              const SizedBox(
                height: 10.0,
              ),
            if (content.isNotEmpty)
              Text(content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).bottomAppBarColor,
                      height: 1.5))
          ],
        ),
      ),
    );
  }

class TodoWidget extends StatelessWidget {
  final String todotitle;
  final bool isComplete;
  final GestureTapCallback onTap;
  final GestureTapCallback onTapDelete;
  const TodoWidget({
    Key? key,
    required this.todotitle,
    required this.isComplete,
    required this.onTap,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12.0),
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: isComplete
                            ? Theme.of(context)
                                .floatingActionButtonTheme
                                .backgroundColor
                            : null,
                        borderRadius: BorderRadius.circular(6.0),
                        border: isComplete
                            ? null
                            : Border.all(
                                color: Theme.of(context).backgroundColor,
                                width: 1.5,
                              ),
                      ),
                    ),
                    if (isComplete)
                      Align(
                        child: Icon(
                          Icons.done,
                          size: 19,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                  ],
                ),
                Flexible(
                  child: Text(
                    todotitle,
                    style: TextStyle(
                        color: isComplete
                            ? Theme.of(context).backgroundColor
                            : Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight:
                            isComplete ? FontWeight.w500 : FontWeight.bold,
                        decoration: isComplete
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTapDelete,
            child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: Icon(Icons.close,
                    color: Theme.of(context).bottomAppBarColor)),
          ),
        ],
      ),
    );
  }

class RadioButton extends StatelessWidget {
  final String titleText;
  final bool isSelected;
  final Color selectedColor;
  final GestureTapCallback onTap;
  final Color textColor;
  const RadioButton({
    Key? key,
    required this.titleText,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleText,
              style: TextStyle(fontSize: 16.0, color: textColor),
            ),
            Container(
              padding: const EdgeInsets.all(2.0),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: selectedColor, width: 2.0),
                borderRadius: BorderRadius.circular(50),
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selectedColor,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
