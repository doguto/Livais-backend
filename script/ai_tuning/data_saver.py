class DataSaver:
    data_file_name: str

    def __init__(self, data_file_name: str) -> None:
        data_file_name = data_file_name

    def save_data(self, user_prompt: str, answer: str):
        with open(self.data_file_name, 'a', encoding='utf-8') as f:
            f.write((
                '{'
                    '"messages": [{'
                        '"role": "system",'
                        '"content": "あなたはROBOSTEPという早稲田大学のサークルに関する質問に答えます。"'
                    '}, {'
                        '"role": "user",'
                        f'"content": "{user_prompt}"'
                    '}, {'
                        '"role": "assistant",'
                        f'"content": "{answer}"'
                    "}]"
                '}\n'
            ))
