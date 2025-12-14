const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

mongoose.connect('mongodb://mongo-service:27017/mydb', {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(() => console.log('MongoDB connected'))
  .catch(err => console.log(err));

const ItemSchema = new mongoose.Schema({ name: String });
const Item = mongoose.model('Item', ItemSchema);

app.get('/', async (req, res) => {
    const items = await Item.find();
    res.json(items);
});

app.post('/add', async (req, res) => {
    const newItem = new Item({ name: req.body.name });
    await newItem.save();
    res.json(newItem);
});

app.listen(3000, () => console.log('Server running on port 3000'));
